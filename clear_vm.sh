#!/bin/bash

# Stop all services
sudo systemctl stop nomad
sudo systemctl stop consul
sudo pkill nomad
sudo pkill consul


# Remove all files in /opt/nomad and /opt/consul
cd /opt/nomad
sudo rm -rf *
cd /opt/consul
sudo rm -rf *

fuser -k 3000/tcp