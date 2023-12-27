#!/bin/bash

# Define source and destination directories
SOURCE_DIR="/opt"
BACKUP_DIR="$HOME/custombackup"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Logging function
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1"
}

# Start the backup process
log "Starting backup of $SOURCE_DIR to $BACKUP_DIR"

# Loop through each subdirectory in /opt
for subdir in "$SOURCE_DIR"/*; do
    if [ -d "$subdir" ]; then
        # Extract the name of the subdirectory
        dir_name=$(basename "$subdir")

        # Define the backup file name
        backup_file="$BACKUP_DIR/${dir_name}_backup_$(date +"%Y%m%d").tar.gz"

        # Create a tar file for the subdirectory
        log "Backing up $subdir to $backup_file"
        tar -czf "$backup_file" -C "$SOURCE_DIR" "$dir_name" 2>/dev/null

        if [ $? -eq 0 ]; then
            log "Successfully backed up $subdir"
        else
            log "Failed to back up $subdir"
        fi
    fi
done

log "Backup process completed"

