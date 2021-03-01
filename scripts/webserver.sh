#!/bin/bash

# Update and Install Apache, OpenSSL
sudo yum update -y
sudo yum install -y httpd mod_ssl openssl

# Setup webpage in Apache
sudo mkdir /var/www/html/terraform
sudo chown  ec2-user /var/www/html/terraform
sudo chmod -R o+r /var/www/html/terraform
echo "<html><h1>Apache deployed successfully by Terraform!!</h1></html>" > /var/www/html/terraform/hello.html

# Enable and Start Apache Service
sudo systemctl start httpd.service
sudo systemctl enable httpd
