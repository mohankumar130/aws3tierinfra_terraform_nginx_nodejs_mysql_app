#!/bin/bash

# Variables
DB_HOST='demo-db.cnmmi3y5t45q.ap-south-1.rds.amazonaws.com'
DB_USER='root'
DB_PASS='Finisher@123'
DB_NAME='logindetails'
TABLE_NAME='users'

# SQL commands
CREATE_DATABASE_SQL="CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
USE_DATABASE_SQL="USE ${DB_NAME};"
CREATE_TABLE_SQL="
CREATE TABLE IF NOT EXISTS ${TABLE_NAME} (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);"

# Connect to MySQL and run the commands
mysql -h ${DB_HOST} -u ${DB_USER} -p${DB_PASS} -e "${CREATE_DATABASE_SQL}"
mysql -h ${DB_HOST} -u ${DB_USER} -p${DB_PASS} -e "${USE_DATABASE_SQL}${CREATE_TABLE_SQL}"

echo "Database and table created successfully."
