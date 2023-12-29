# ManageEngine ServiceDesk Plus Docker Image

This project contains the necessary configurations to run ManageEngine ServiceDesk Plus in a Docker container. It's designed for enhanced security, flexibility, and customization.

## Features

- **Non-Root User:** Runs as a non-root user (`servicedesk`) for security.
- **Customizable Installation:** Through `installer.properties`.
- **UID/GID Mapping:** Aligns file permissions with the host system.
- **Docker Compose Integration:** For easy setup and management.

## Getting Started

### Prerequisites

- Docker and Docker Compose installed.
- Basic understanding of Docker and shell scripting.
- Git (optional, for cloning the repository).

### Installation

1. **Clone the Repository (Optional):**
   ```bash
   git clone [repository-url]
   cd [repository-name]
   ```

2. Run builddocker.sh

3. Run init.sh to build the directories in /opt/

4. **Run the Setup Script:**
   ```bash
   docker run -it -p 8080:8080 -p 8443:8443 --name manageengine-sdp -v /opt/manageengine-sdp/ServiceDesk:/opt/m
anageengine-sdp/ServiceDesk manageengine-sdp
   ```

5. **Alternatively, Run the Container from the GHCR repo:**
   If you prefer not to build the image yourself, you can run the container directly from the GitHub Container Registry:
   ```bash
   docker run -d -p 8080:8080 -p 8443:8443 --name managedengine-sdp -v /opt/manageengine-sdp/ServiceDesk:/opt/m
anageengine-sdp/ServiceDesk ghcr.io/azlaroc/manageengine-sdp:latest
   ```

### Key Files and Their Roles

- `Dockerfile`: Contains instructions for building the Docker image, setting up the non-root user, and installing dependencies.
- `entrypoint.sh`: The script that runs on container startup, checks for ServiceDesk Plus installation, and starts the service.
- `installer.properties`: Configuration file for customizing the ServiceDesk Plus installation.
- `ManageEngine_ServiceDesk_Plus.bin`: The binary installer for ManageEngine ServiceDesk Plus.
- `init.sh` : sets up the directories and gives them the correct permissions in /opt/
- `reset.sh` : stops the container and removes it and deletes the directories in /opt/ like a factory reset 

### DB Info

cd /opt/manageengine-sdp/ServiceDesk/pgsql/bin/
./psql -h localhost -U sdpadmin -W sdp@123 -p 65432 -d servicedesk

### Usage

After running the setup script, access ServiceDesk Plus at `https://localhost:8443`.

## Contributing

Contributions are welcome. Please follow best practices and coding standards.

## License

Use at your own risk. Adhere to the licensing terms of ManageEngine ServiceDesk Plus and Docker.