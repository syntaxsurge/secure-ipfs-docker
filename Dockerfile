# Use the official IPFS image from Docker Hub
FROM ipfs/go-ipfs:latest

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose IPFS ports
EXPOSE ${IPFS_API_PORT} ${IPFS_GATEWAY_PORT} ${IPFS_SWARM_PORT}

# Start IPFS daemon with the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
