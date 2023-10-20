#!/bin/bash

# Task 1: Create a VM on Azure and access it via SSH
# Replace these values with your Azure subscription details
resourceGroup="myResourceGroup"
location="East US"
vmName="myVM"
vmSize="Standard_B1s"  # Choose an appropriate VM size
adminUser="yourusername"
adminPassword="yourpassword"
imageName="UbuntuLTS"

# Create resource group
az group create --name $resourceGroup --location $location

# Create VM
az vm create --resource-group $resourceGroup --name $vmName --image $imageName --admin-username $adminUser --admin-password $adminPassword --size $vmSize

# Task 2: Install and configure NGINX
# SSH into the VM
ssh $adminUser@$vmName

# Update the package list and install NGINX
sudo apt update
sudo apt install -y nginx

# Create necessary directories and files
sudo mkdir -p /var/www/html/labs
sudo chown -R $USER:$USER /var/www/html/labs
ln -s /var/www/html/labs ~/html
echo "Hello, this is my NGINX webpage!" | tee ~/html/index.html

# Test NGINX
sudo systemctl start nginx
sudo systemctl enable nginx

# Task 3: Setting up MySQL Database
# Install MySQL
sudo apt install -y mysql-server

# Secure MySQL installation (set root password and remove test databases)
sudo mysql_secure_installation

# Create a MySQL user and database for your application
mysql -u root -p
# Enter the MySQL root password when prompted
CREATE DATABASE student_records;
CREATE USER 'youruser'@'localhost' IDENTIFIED BY 'yourpassword';
GRANT ALL PRIVILEGES ON student_records.* TO 'youruser'@'localhost';
FLUSH PRIVILEGES;
exit

# Task 4: Creating Student Table and Data
# Use a MySQL client (e.g., mysql command-line or a MySQL GUI) to create the table and insert data

# Example SQL statements to create a 'students' table
# CREATE TABLE students (
#     student_id INT AUTO_INCREMENT PRIMARY KEY,
#     name VARCHAR(255),
#     age INT,
#     gender VARCHAR(10),
#     course VARCHAR(255)
# );

# Example SQL statement to insert data
# INSERT INTO students (name, age, gender, course) VALUES ('John Doe', 20, 'Male', 'Computer Science');
# INSERT INTO students (name, age, gender, course) VALUES ('Jane Smith', 22, 'Female', 'Mathematics');

# Remember to replace 'youruser' and 'yourpassword' with your MySQL user and password.

# To access the MySQL server from the command line, use the following command:
# mysql -u youruser -p


