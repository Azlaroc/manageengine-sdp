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

2. **Run the Setup Script:**
   ```bash
   ./run-docker-compose.sh
   ```

3. **Alternatively, Run the Container from the GHCR repo:**
   If you prefer not to build the image yourself, you can run the container directly from the GitHub Container Registry:
   ```bash
   docker run -d -p 8080:8080 -p 8443:8443 --name managedengine-sdp ghcr.io/azlaroc/manageengine-sdp:latest
   ```

### Key Files and Their Roles

- `.env`: Defines environment variables for PostgreSQL and host port configurations.
- `docker-compose.yml`: Configures the Docker multi-container setup, including service definitions and volume mappings.
- `Dockerfile`: Contains instructions for building the Docker image, setting up the non-root user, and installing dependencies.
- `entrypoint.sh`: The script that runs on container startup, checks for ServiceDesk Plus installation, and starts the service.
- `installer.properties`: Configuration file for customizing the ServiceDesk Plus installation.
- `ManageEngine_ServiceDesk_Plus.bin`: The binary installer for ManageEngine ServiceDesk Plus.
- `run-docker-compose.sh`: Script to set the current user's UID and GID and run Docker Compose.

### Usage

After running the setup script, access ServiceDesk Plus at `http://localhost:<HOST_PORT_SDP_HTTP>` or `https://localhost:<HOST_PORT_SDP_HTTPS>`.

## Contributing

Contributions are welcome. Please follow best practices and coding standards.

## License

Use at your own risk. Adhere to the licensing terms of ManageEngine ServiceDesk Plus and Docker.
