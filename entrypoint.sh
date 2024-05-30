#!/bin/sh
echo "Running entrypoint script"
env
ls -l /usr/local/bin

# Initialize IPFS repo if not already initialized
if [ ! -d "/root/.ipfs" ]; then
  ipfs init
fi

# Update IPFS config with custom ports
ipfs config Addresses.API /ip4/0.0.0.0/tcp/${IPFS_API_PORT}
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/${IPFS_GATEWAY_PORT}
ipfs config Addresses.Swarm --json '["/ip4/0.0.0.0/tcp/'${IPFS_SWARM_PORT}'", "/ip6/::/tcp/'${IPFS_SWARM_PORT}'"]'

# Configure CORS for IPFS API
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://0.0.0.0:5001", "http://localhost:3000", "http://127.0.0.1:5001", "https://webui.ipfs.io"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]'

# Replace placeholders in nginx.conf with actual values
sed -i "s/\$IPFS_GATEWAY_PORT/${IPFS_GATEWAY_PORT}/g" /etc/nginx/nginx.conf

# Replace placeholder for whitelisted IPs
whitelisted_ips=$(echo $WHITELISTED_IPS | tr ',' '\n' | sed 's/^/allow /' | sed 's/$/;/' | tr '\n' ' ')
sed -i "s/# WHITELISTED_IPS_PLACEHOLDER/${whitelisted_ips}/g" /etc/nginx/nginx.conf

# Start the IPFS daemon
ipfs daemon --migrate=true &

# Start Nginx
nginx -g 'daemon off;'
