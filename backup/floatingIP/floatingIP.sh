#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <vm_name>"
    echo "Example: $0 laiterie"
    exit 1
fi

sudo apt-get install keepalived
sudo apt-get install haproxy

sudo rm -rf /etc/keepalived/keepalived.conf
sudo rm -rf /etc/keepalived/check_haproxy.sh

sudo cp /$1/keepalived.conf /etc/keepalived/keepalived.conf
sudo cp check_haproxy.sh /etc/keepalived/check_haproxy.sh

sudo systemctl restart keepalived
sudo systemctl restart haproxy