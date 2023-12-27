#!/bin/bash

TRAFFIK_CONFIG_DIR="/opt/traefik"
TRAFFIK_CONTAINER_NAME="traefik"

# Function to log messages
log_message() {
    echo "$(date): $1"
}

# Check if Traefik configuration directory exists
if [ -d "$TRAFFIK_CONFIG_DIR" ]; then
    log_message "Traefik configuration directory found. Listing contents:"
    ls -l "$TRAFFIK_CONFIG_DIR"
else
    log_message "Traefik configuration directory not found at $TRAFFIK_CONFIG_DIR."
    exit 1
fi

# Display contents of Traefik configuration files
log_message "Contents of Traefik configuration files:"
for file in "$TRAFFIK_CONFIG_DIR"/*; do
    echo "Contents of $file:"
    cat "$file"
    echo "-----------------------------------"
done

# Check if Traefik is running
log_message "Checking if Traefik is running:"
if docker ps | grep -q "$TRAFFIK_CONTAINER_NAME"; then
    log_message "Traefik container is running."
else
    log_message "Traefik container is not running."
fi

# Check Traefik ports
log_message "Checking Traefik ports:"
docker port "$TRAFFIK_CONTAINER_NAME"

# Manual checks
echo "Please perform the following manual checks:"
echo "1. Review the displayed Traefik configuration files for any redirect loops or misconfigurations."
echo "2. Clear your browser cache or try accessing the URL in incognito mode."
echo "3. Access the Traefik dashboard directly and inspect routes and middleware configurations."
echo "4. Check Traefik logs for clues about redirects."
echo "5. Ensure DNS settings for dash.cetechlab.com are correct."
echo "6. Review interactions between different middlewares in Traefik."

# End of script
