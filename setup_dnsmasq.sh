#!/bin/bash

# Update package list and install dnsmasq
echo "Installing dnsmasq..."
sudo apt update
sudo apt install -y dnsmasq

# Download and install the hosts file
echo "Downloading and replacing hosts file..."
curl -o /etc/hosts https://raw.githubusercontent.com/khantzawhein/outline-server-dnsmasq-setup/refs/heads/main/hosts

# Download and replace the dnsmasq configuration file
echo "Downloading and replacing dnsmasq.conf..."
curl -o /etc/dnsmasq.conf https://raw.githubusercontent.com/khantzawhein/outline-server-dnsmasq-setup/refs/heads/main/dnsmasq.conf

# Download and replace the resolv.conf file
echo "Downloading and replacing resolv.conf..."
curl -o /etc/resolv.conf https://raw.githubusercontent.com/khantzawhein/outline-server-dnsmasq-setup/refs/heads/main/resolv.conf

# Stop and disable systemd-resolved
echo "Stopping and disabling systemd-resolved..."
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved

# Restart dnsmasq
echo "Restarting dnsmasq..."
sudo systemctl restart dnsmasq

# Test with nslookup
echo "Testing DNS with nslookup..."
nslookup example.com

# Final instruction
echo "Restart Outline Servers to apply changes."
sudo docker restart $(sudo docker ps -q)
