#!/bin/bash

# Create directories
echo "Creating directories..."
sudo mkdir -p /opt/manageengine-sdp/ServiceDesk
sudo mkdir -p /opt/manageengine-sdp/db-data

# Set permissions
echo "Setting permissions..."
sudo chown -R sysdmoore:sysdmoore /opt/manageengine-sdp

# Run Docker Compose
echo "Starting Docker containers..."
./run-docker-compose.sh

echo "Initialization complete."
