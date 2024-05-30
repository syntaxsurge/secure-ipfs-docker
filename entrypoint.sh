#!/bin/bash

# Allow localhost
iptables -A INPUT -s 127.0.0.1 -j ACCEPT

# Allow specific IP range
iptables -A INPUT -s 49.144.223.21 -j ACCEPT

# Allow traffic on specific ports
iptables -A INPUT -p tcp --dport ${IPFS_SWARM_PORT} -j ACCEPT
iptables -A INPUT -p tcp --dport ${IPFS_API_PORT} -j ACCEPT
iptables -A INPUT -p tcp --dport ${IPFS_GATEWAY_PORT} -j ACCEPT

# Drop all other incoming traffic
iptables -A INPUT -j DROP

# Update IPFS config with custom ports
ipfs config Addresses.API /ip4/0.0.0.0/tcp/${IPFS_API_PORT}
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/${IPFS_GATEWAY_PORT}
ipfs config Addresses.Swarm --json '["/ip4/0.0.0.0/tcp/'${IPFS_SWARM_PORT}'", "/ip6/::/tcp/'${IPFS_SWARM_PORT}'"]'

# Start the IPFS daemon
exec ipfs daemon --migrate=true
