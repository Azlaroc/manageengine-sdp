# manageengine-sdp

# ManageEngine ServiceDesk Plus Docker Image

This project contains the Dockerfile and necessary configurations to run ManageEngine ServiceDesk Plus in a Docker container. The setup includes a non-root user for enhanced security and supports various configuration options through an `installer.properties` file.

## Features

- **Non-Root User:** Runs ServiceDesk Plus as a non-root user (`servicedesk`) for improved security.
- **Customizable Installation:** Configuration options available through `installer.properties`.
- **Flexible and Secure:** Designed with best practices in Docker containerization.

## Getting Started

### Prerequisites

- Docker installed on your system.
- Basic understanding of Docker commands and concepts.

### Installation

1. **Clone the Repository:**
   ```bash
   git clone [repository-url]
   cd [repository-name]
   ```

2. **Build the Docker Image:**
   ```bash
   docker build -t managedengine-sdp .
   ```

3. **Run the Container from the local cloned git repo:**
   ```bash
   docker run -d -p 8080:8080 -p 8443:8443 --name managedengine-sdp managedengine-sdp
   ```
   
5. **Run the Container from the GHCR repo:**
   ```bash
   docker run -d -p 9090:8080 -p 9443:8443 --name managedengine-sdp ghcr.io/azlaroc/manageengine-sdp:latest
   ```

### Configuration

#### Environment Variables

- `SDP_USER`: The username for the ServiceDesk application (default: `servicedesk`).
- `SDP_PASSWORD`: The password for the ServiceDesk application.

#### `installer.properties`

This file contains various configuration options for ServiceDesk Plus. You can customize:

- Installation directory
- Database settings
- Port configurations
- ...and more.

### Customization

To customize your installation, edit the `installer.properties` file before building the Docker image. 

### User Details

- **Username:** The default username is `servicedesk`.
- **Password:** The default password is set in the `installer.properties` file.

## Usage

After running the container, access ServiceDesk Plus at `http://localhost:8080` or `https://localhost:8443`.

## Contributing

Contributions to this project are welcome. Please ensure to follow the best practices and coding standards.

## License

Use at your own risk.

