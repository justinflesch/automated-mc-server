#!/bin/bash

# Install Java
sudo apt update
sudo apt install -y default-jre

# Download MC server files, do the latest version
wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.19.83.01.zip

# Install unzip
sudo apt install -y unzip

# Unzip the server files, again update the version if need be
unzip bedrock-server-1.19.83.01.zip -d minecraft_server

# cd to the server files
cd minecraft_server

# Accept the Minecraft EULA
echo "eula=true" > eula.txt

# Specify server name, do your name here if you'd like
new_server_name="Jay's Minecraft Server"

# Define path to server.properties file
properties_file="/home/ubuntu/minecraft-server/server.properties"

# Use sed to update the server name in the properties file
sed -i "s/^server-name=.*/server-name=$new_server_name/" "$properties_file"

# Add MC server startup command to crontab
(crontab -l ; echo "@reboot cd /home/ubuntu/minecraft-server; LD_LIBRARY_PATH=.; ./bedrock_server") | crontab -

# Start the MC server now
LD_LIBRARY_PATH=. ./bedrock_server
