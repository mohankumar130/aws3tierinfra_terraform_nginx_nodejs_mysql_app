#!/bin/bash

# Get the private IP address of the Nginx server
NGINX_IP=$(hostname -I | awk '{print $1}')

# Get the private IP address of the Node.js server (you can adjust this based on your environment)
NODE_IP="0.0.0.0"  # This can be dynamically fetched if needed

# Path to your Nginx configuration file
CONF_FILE="/etc/nginx/conf.d/proxy.conf"

# Backup the existing configuration file
sudo cp $CONF_FILE $CONF_FILE.bak

# Update server_name and proxy_pass in the configuration file
sudo sed -i "s/server_name .*/server_name $NGINX_IP;/" $CONF_FILE
sudo sed -i "s#proxy_pass http://.*:#proxy_pass http://$NODE_IP:3000;#" $CONF_FILE

# Reload Nginx to apply the changes
sudo systemctl reload nginx

echo "Nginx configuration updated with server name $NGINX_IP and proxy pass to $NODE_IP:3000"
