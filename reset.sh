#!/bin/bash

# Confirmation prompt
read -p "Are you sure you want to reset the environment? This will remove all existing data. (y/N): " confirm
if [[ $confirm != [yY] ]]; then
    echo "Reset cancelled."
    exit 1
fi

# Stop and remove Docker containers and volumes
echo "Stopping Docker containers..."
docker compose down -v

# Remove directories
echo "Removing directories..."
sudo rm -rf /opt/manageengine-sdp

echo "Reset complete."
