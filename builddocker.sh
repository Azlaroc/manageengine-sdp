#!/bin/bash

# Get current user's UID and GID
CURRENT_UID=$(id -u)
CURRENT_GID=$(id -g)

# Build the Docker image with the current UID and GID
docker build --build-arg UID=$CURRENT_UID --build-arg GID=$CURRENT_GID -t manageengine-sdp .
