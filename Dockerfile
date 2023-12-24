# Use Ubuntu 22.04 LTS as the base image
FROM ubuntu:22.04

# Set a non-interactive frontend for apt (prevents prompts during installation)
ARG DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    openjdk-11-jdk \
    unzip \
    && rm -rf /var/lib/apt/lists/*  # Clean up to reduce image size

# Create a directory for ServiceDesk Plus
RUN mkdir -p /opt/manageengine-sdp

# Set the working directory to the ServiceDesk Plus directory
WORKDIR /opt/manageengine-sdp/ServiceDesk/bin

# Copy the ServiceDesk Plus installation file and installer properties file into the container
COPY ManageEngine_ServiceDesk_Plus.bin installer.properties /opt/manageengine-sdp/

# Give execution permissions to the installer
RUN chmod +x /opt/manageengine-sdp/ManageEngine_ServiceDesk_Plus.bin

# Run the installer in silent mode using the installer properties file
RUN /opt/manageengine-sdp/ManageEngine_ServiceDesk_Plus.bin -i silent -f /opt/manageengine-sdp/installer.properties

# Expose necessary ports
EXPOSE 8080 8443

# Define the command to start ServiceDesk Plus

# Normal CMD
#CMD ["/opt/manageengine-sdp/ServiceDesk/bin/run.sh"]

#Debug CMD
CMD ["/bin/bash"]

#These permission changes need to happen after initial boot
#chmod -R 755 /opt/manageengine-sdp/ServiceDesk

#chown -R postgres:postgres /opt/manageengine-sdp/ServiceDesk

#chown -R postgres:postgres /opt/manageengine-sdp/ServiceDesk/pgsql

#chmod -R 700 /opt/manageengine-sdp/ServiceDesk/pgsql/data

#chmod +x /opt/manageengine-sdp/ServiceDesk/pgsql/bin/pg_ctl

#chmod +x /opt/manageengine-sdp/ServiceDesk/bin/startDB.sh

#su -c '/opt/manageengine-sdp/ServiceDesk/bin/startDB.sh' postgres

#./run.sh

#They work but i still need to slim the permission up for security.

