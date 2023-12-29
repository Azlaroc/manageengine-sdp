#!/bin/bash

# Set variables
container_name="manageengine-sdp"
change_port_script="/opt/manageengine-sdp/ServiceDesk/bin/changeWebServerPort.sh"
new_port="8080"
protocol="http"

# Run the changeWebServerPort.sh script inside the Docker container
# and automatically answer 'y' to the prompt
echo "y" | docker exec -i $container_name /bin/bash -c "cd ServiceDesk/bin && sh $change_port_script $new_port $protocol"

# Check if the docker exec command was successful
if [ $? -eq 0 ]; then
    echo "Port change script executed successfully. Restarting the Docker container."
    # Restart the Docker container
    docker restart $container_name
else
    echo "Failed to execute the port change script."
fi
