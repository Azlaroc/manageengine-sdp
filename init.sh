#!/bin/bash

# Export current user's UID and GID
export CURRENT_UID=$(id -u)
export CURRENT_GID=$(id -g)

# Create directories with error checking
echo "Creating directories..."
sudo mkdir -p /opt/manageengine-sdp/ServiceDesk || { echo "Failed to create ServiceDesk directory"; exit 1; }
sudo mkdir -p /opt/manageengine-sdp/db-data || { echo "Failed to create db-data directory"; exit 1; }

# Set permissions using the exported UID and GID
echo "Setting permissions..."
sudo chown -R $CURRENT_UID:$CURRENT_GID /opt/manageengine-sdp || { echo "Failed to set permissions"; exit 1; }

# Run Docker Compose with error checking
echo "Starting Docker containers..."
docker compose build || { echo "Docker build failed"; exit 1; }
docker compose up -d || { echo "Docker compose up failed"; exit 1; }

echo "Initialization complete."



