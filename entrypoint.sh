#!/bin/bash

# Check if ServiceDesk Plus is already installed
if [ ! -d "/opt/manageengine-sdp/ServiceDesk" ]; then
    echo "Installing ManageEngine ServiceDesk Plus..."
    chmod +x /opt/manageengine-sdp/ManageEngine_ServiceDesk_Plus.bin
    /opt/manageengine-sdp/ManageEngine_ServiceDesk_Plus.bin -i silent -f /opt/manageengine-sdp/installer.properties
fi

# Change to the ServiceDesk Plus 'bin' directory
cd /opt/manageengine-sdp/ServiceDesk/bin

# Start ServiceDesk Plus
exec ./run.sh
