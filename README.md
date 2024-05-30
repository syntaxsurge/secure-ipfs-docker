# Docker IPFS Node with IP Whitelisting

This repository contains a Docker setup for hosting an IPFS node with IP whitelisting. The IPFS node runs inside a Docker container and uses Nginx to restrict access to specific IP addresses. You can also configure the ports for the IPFS API, Gateway, and Swarm.

## Features

- Run an IPFS node inside a Docker container
- Whitelist specific IP addresses for access
- Configure IPFS API, Gateway, and Swarm ports using environment variables
- Uses Nginx for enhanced security

## Prerequisites

- Docker
- Docker Compose

## Installation

1. Clone this repository:

    ```bash
    git clone https://github.com/syntaxsurge/docker-ipfs-whitelist.git
    cd docker-ipfs-whitelist
    ```

2. Build the Docker image:

    ```bash
    docker compose build
    ```

3. Run the Docker container:

    ```bash
    docker compose up -d
    ```

## Configuration

### IP Whitelisting

By default, the IP whitelist includes localhost (`127.0.0.1`) and a specific IP range (`49.144.223.21`). You can modify the `.env` file to change the IP addresses as needed.

#### Example `.env` file

```env
IPFS_API_PORT=5001
IPFS_GATEWAY_PORT=8081
IPFS_SWARM_PORT=4002
WHITELISTED_IPS=127.0.0.1,49.144.223.21
```

### Custom Ports

You can configure the ports for the IPFS API, Gateway, and Swarm by setting environment variables in the `.env` file. The default ports are:

- `IPFS_API_PORT=5001`
- `IPFS_GATEWAY_PORT=8081`
- `IPFS_SWARM_PORT=4002`

To change the ports, update the values in the `.env` file:

```env
IPFS_API_PORT=YourCustomApiPort
IPFS_GATEWAY_PORT=YourCustomGatewayPort
IPFS_SWARM_PORT=YourCustomSwarmPort
```

## Running the IPFS Node

To start the IPFS node, use Docker Compose:

```bash
docker compose down --remove-orphans && \
docker compose build && docker compose up -d && docker logs -f ipfs_node
```

This will build, run, and show the logs of the Docker container with the IPFS node, applying the IP whitelisting rules and exposing the configured ports.

## Viewing Logs

To view the logs of the running Docker container in detached mode, use the following command:

```bash
docker logs -f ipfs_node
```

This will display the logs of the IPFS node container and follow the log output in real-time.

## Testing the IPFS Node

To test if the IPFS node is running, you can use the following `curl` command to fetch a known IPFS hash and follow redirects. Replace `8081` with the value of `IPFS_GATEWAY_PORT` if you have changed it in the `.env` file:

```bash
curl -L http://localhost:8081/ipfs/QmSfYnQSoUfuvd2SUGfHdfvqUSq8tyYmWBA7k7dt1o5MWV
```

If the IPFS node is running correctly, this command should return the content associated with the IPFS hash `QmSfYnQSoUfuvd2SUGfHdfvqUSq8tyYmWBA7k7dt1o5MWV`.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with any changes or improvements.
