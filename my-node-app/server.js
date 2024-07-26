const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const app = express();
const PORT = process.env.PORT || 3000;
const bcrypt = require('bcrypt');
// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));

const db = mysql.createConnection({
    host: 'demo-db.cnmmi3y5t45q.ap-south-1.rds.amazonaws.com',         // Your host, usually localhost
    user: 'root',      // Your database username
    password: 'Finisher@123',  // Your database password
    database: 'logindetails'     // Your database name
});

// Connect to the database
db.connect(err => {
    if (err) {
        console.error('Database connection error:', err);
    } else {
        console.log('Connected to MySQL database');
    }
});



// Set view engine to EJS
app.set('view engine', 'ejs');

// Routes
app.get('/', (req, res) => {
    res.render('index');
});

app.get('/login', (req, res) => {
    res.render('login');
});

app.get('/register', (req, res) => {
    res.render('register');
});

app.get('/forgot-password', (req, res) => {
    res.render('forgot-password');
});

app.get('/game', (req, res) => {
    res.render('game');
});

app.post('/login', async (req, res) => {
    const { username, password } = req.body;

    // Trim inputs to remove any leading or trailing whitespace
    const trimmedUsername = username.trim();
    const trimmedPassword = password.trim();

    // Query the user by username
    const sql = 'SELECT * FROM users WHERE username = ?';
    db.query(sql, [trimmedUsername], async (err, results) => {
        if (err) {
            console.error('Error querying user:', err);
            return res.status(500).send('Internal server error.');
        }

        if (results.length === 0) {
            return res.status(401).send('Invalid credentials. Please try again.');
        }

        const user = results[0];

        try {
            // Compare the hashed password
            const match = await bcrypt.compare(trimmedPassword, user.password);
            if (!match) {
                return res.status(401).send('Invalid credentials. Please try again.');
            }

            res.redirect('/game');
        } catch (compareErr) {
            console.error('Error comparing passwords:', compareErr);
            return res.status(500).send('Internal server error.');
        }
    });
});



app.post('/register', async (req, res) => {
    const { username, email, password } = req.body;

    try {
        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Insert the new user into the database
        const sql = 'INSERT INTO users (username, email, password) VALUES (?, ?, ?)';
        db.query(sql, [username, email, hashedPassword], (err, results) => {
            if (err) {
                console.error('Registration error:', err);
                return res.status(500).send('Error registering user. Possible duplicate email or username.');
            }
            res.redirect('/');
        });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Error registering user.');
    }
});

app.post('/forgot-password', (req, res) => {
    // Handle forgot password logic here
    res.send('Forgot password functionality not yet implemented');
});

app.listen(PORT,'0.0.0.0', () => {
    console.log(`Server is running on http://0.0.0.0:${PORT}`);
});
