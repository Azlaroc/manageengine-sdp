# Use Debian Slim as the base image
FROM debian:bullseye-slim

# Set a non-interactive frontend (useful for some packages that ask configuration questions)
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jre-headless \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*  # Clean up to reduce image size

# Create a non-root user and group (e.g., servicedesk)
RUN groupadd -r servicedesk && useradd -r -g servicedesk servicedesk

# Create a directory for ServiceDesk Plus and give access to servicedesk user
RUN mkdir -p /opt/manageengine-sdp && chown servicedesk:servicedesk /opt/manageengine-sdp

# Switch to the non-root user
USER servicedesk

# Set the working directory to where the ServiceDesk Plus installation files should be copied
WORKDIR /opt/manageengine-sdp

# Copy the ServiceDesk Plus installation file and installer properties file into the container
# Ensure the copied files are owned by the servicedesk user
# Note: You need to have these files in your build context
COPY --chown=servicedesk:servicedesk ManageEngine_ServiceDesk_Plus.bin installer.properties /opt/manageengine-sdp/

# Give execution permissions to the installer and run it
RUN chmod +x /opt/manageengine-sdp/ManageEngine_ServiceDesk_Plus.bin && \
    ./ManageEngine_ServiceDesk_Plus.bin -i silent -f installer.properties

# Change the working directory to the ServiceDesk Plus 'bin' directory
# Note: Update the path according to where ServiceDesk Plus is installed
WORKDIR /opt/manageengine-sdp/ServiceDesk/bin

# Expose necessary ports
EXPOSE 8080 8443

# Define the command to start ServiceDesk Plus
CMD ["./run.sh"]
