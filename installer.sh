#!/bin/bash

# Exit on error
set -e

# Install NVM and Node.js
echo "Installing NVM and Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts

# Move files to the appropriate location
echo "Moving files..."
mv /home/ec2-user/aws3tierinfra_terraform_nginx_nodejs_mysql_app/my-node-app /home/ec2-user
mv /home/ec2-user/aws3tierinfra_terraform_nginx_nodejs_mysql_app/database.sh /home/ec2-user

# Navigate to the app directory
cd /home/ec2-user/my-node-app

# Initialize npm project and install dependencies
echo "Initializing npm project and installing dependencies..."
npm init -y
npm install express body-parser mysql2 bcrypt ejs

# Install PM2 globally and start the Node.js application
echo "Installing PM2 and starting the Node.js application..."
npm install -g pm2
pm2 start /home/ec2-user/my-node-app/server.js --name 'loginapp'

# Install MySQL client
echo "Installing MySQL client..."
sudo wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
sudo dnf install mysql80-community-release-el9-1.noarch.rpm -y
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
sudo dnf install mysql-community-client -y

# Clean up
echo "Cleaning up..."
rm -rf /home/ec2-user/aws3tierinfra_terraform_nginx_nodejs_mysql_app