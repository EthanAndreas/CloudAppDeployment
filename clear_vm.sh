#!/bin/bash

# Stop all services
sudo systemctl stop nomad
sudo systemctl stop consul
sudo systemctl stop keepalived
sudo pkill nomad
sudo pkill consul
sudo pkill keepalived


# Remove all files in /opt/nomad and /opt/consul
cd /opt/nomad
sudo rm -rf *
cd /opt/consul
sudo rm -rf /opt/keepalived
sudo rm -rf /etc/consul.d
sudo rm -rf /etc/nomad.d
sudo rm -rf /etc/keepalived
cd

fuser -k 3000/tcp