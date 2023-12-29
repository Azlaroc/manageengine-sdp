# Use Debian Slim as the base image
FROM debian:bullseye-slim

# Set a non-interactive frontend (useful for some packages that ask configuration questions)
ENV DEBIAN_FRONTEND=noninteractive

# Accept UID and GID as build arguments
ARG UID
ARG GID

# Update the package list and install necessary dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jre-headless \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*  # Clean up to reduce image size

# Create a servicedesk group with the specified GID
RUN groupadd -r -g ${GID} servicedesk

# Create a servicedesk user with the specified UID and add to the servicedesk group
RUN useradd -r -u ${UID} -g servicedesk servicedesk

# Switch to the non-root user
USER servicedesk

# Set the working directory
WORKDIR /opt/manageengine-sdp

# Copy the ServiceDesk Plus installation file, installer properties file, and entrypoint script into the container
# Ensure the copied files are owned by the servicedesk user
COPY --chown=servicedesk:servicedesk ManageEngine_ServiceDesk_Plus.bin installer.properties entrypoint.sh /opt/manageengine-sdp/

# Give execution permissions to the entrypoint script
RUN chmod +x /opt/manageengine-sdp/entrypoint.sh

# Expose necessary ports
EXPOSE 8080 8443

# Set the entrypoint script
ENTRYPOINT ["/opt/manageengine-sdp/entrypoint.sh"]

# DEBUG
# Start with a Bash shell
# CMD ["/bin/bash"]
