# Stage 1: Use the official IPFS image from Docker Hub
FROM ipfs/go-ipfs:latest as ipfs

# Stage 2: Use the official Nginx image from Docker Hub
FROM nginx:latest

# Copy the IPFS binary and configuration files from the IPFS stage
COPY --from=ipfs /usr/local/bin/ipfs /usr/local/bin/ipfs
COPY --from=ipfs /usr/local/bin/container_init_run /usr/local/bin/container_init_run
COPY --from=ipfs /usr/local/bin/start_ipfs /usr/local/bin/start_ipfs
COPY --from=ipfs /usr/local/bin/fusermount /usr/local/bin/fusermount
COPY --from=ipfs /usr/local/bin/container_init_run /usr/local/bin/container_init_run
COPY --from=ipfs /data/ipfs /data/ipfs

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose IPFS and Nginx ports
EXPOSE ${IPFS_API_PORT} ${IPFS_GATEWAY_PORT} ${IPFS_SWARM_PORT} 8082

# Start Nginx and IPFS daemon with the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
