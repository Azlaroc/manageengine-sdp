#!/bin/bash

# Function to confirm action
confirm_action() {
    read -p "Are you sure you want to proceed? (yes/no): " confirmation
    if [[ $confirmation != "yes" ]]; then
        echo "Action cancelled."
        return 1
    fi
    return 0
}

# Function to backup a directory
backup_directory() {
    local source_dir=$1
    local backup_dir=$2
    local dir_name=$(basename "$source_dir")
    local backup_file="$backup_dir/${dir_name}_backup_$(date +"%Y%m%d").tar.gz"

    echo "Backup: $source_dir to $backup_file"
    confirm_action || return

    tar -czf "$backup_file" -C "$(dirname "$source_dir")" "$dir_name" && echo "Backup completed successfully" || echo "Backup failed"
}

# Function to backup a directory to rclone:google
backup_to_rclone() {
    local source_dir=$1
    local remote_dir=$2
    local dir_name=$(basename "$source_dir")
    local remote_path="rclone:google/$remote_dir/${dir_name}_backup_$(date +"%Y%m%d").tar.gz"

    echo "Backup: $source_dir to $remote_path"
    confirm_action || return

    tar -czf - "$source_dir" | rclone rcat -v "$remote_path" 2>>rclone_backup.log && echo "Backup to rclone:google completed successfully" || echo "Backup to rclone:google failed"
}

# Function to restore a directory
restore_directory() {
    local backup_file=$1
    local restore_dir=$2

    echo "Restore: $backup_file to $restore_dir"
    confirm_action || return

    tar -xzf "$backup_file" -C "$restore_dir" && echo "Restore completed successfully" || echo "Restore failed"
}

# Function to restore a directory from rclone:google
restore_from_rclone() {
    local remote_file=$1
    local restore_dir=$2

    echo "Restore: rclone:google/$remote_file to $restore_dir"
    confirm_action || return

    rclone cat -v "rclone:google/$remote_file" 2>>rclone_restore.log | tar -xzf - -C "$restore_dir" && echo "Restore from rclone:google completed successfully" || echo "Restore from rclone:google failed"
}

# Function to copy files
copy_files() {
    local source=$1
    local destination=$2

    echo "Copy: $source to $destination"
    confirm_action || return

    cp -r "$source" "$destination" && echo "Copy completed successfully" || echo "Copy failed"
}

# Function to move files
move_files() {
    local source=$1
    local destination=$2

    echo "Move: $source to $destination"
    confirm_action || return

    mv "$source" "$destination" && echo "Move completed successfully" || echo "Move failed"
}

# Function to display the menu
show_menu() {
    echo "1. Backup a directory locally"
    echo "2. Restore a directory locally"
    echo "3. Backup a directory to rclone:google"
    echo "4. Restore a directory from rclone:google"
    echo "5. Copy files"
    echo "6. Move files"
    echo "7. Exit"
    read -p "Enter your choice: " choice
    return $choice
}

# Main loop
while true; do
    show_menu
    choice=$?

    case $choice in
        1) # Local Backup
            read -p "Enter the directory to backup: " source_dir
            read -p "Enter the destination backup directory: " backup_dir
            backup_directory "$source_dir" "$backup_dir"
            ;;
        2) # Local Restore
            read -p "Enter the backup file to restore: " backup_file
            read -p "Enter the destination restore directory: " restore_dir
            restore_directory "$backup_file" "$restore_dir"
            ;;
        3) # Backup to rclone:google
            read -p "Enter the directory to backup: " source_dir
            read -p "Enter the remote directory in rclone:google: " remote_dir
            backup_to_rclone "$source_dir" "$remote_dir"
            ;;
        4) # Restore from rclone:google
            read -p "Enter the remote file in rclone:google to restore: " remote_file
            read -p "Enter the destination restore directory: " restore_dir
            restore_from_rclone "$remote_file" "$restore_dir"
            ;;
        5) # Copy files
            read -p "Enter the source path: " source
            read -p "Enter the destination path: " destination
            copy_files "$source" "$destination"
            ;;
        6) # Move files
            read -p "Enter the source path: " source
            read -p "Enter the destination path: " destination
            move_files "$source" "$destination"
            ;;
        7) # Exit
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
done
