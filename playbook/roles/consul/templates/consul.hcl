# Group name
datacenter = "gare-centrale"

# Save the persistent data to /opt/consul. This directory is owned by the `consul` user.
data_dir = "/opt/consul"
node_name = "{{ inventory_hostname }}"

# Allow clients to connect from any interface
client_addr = "0.0.0.0"

# Advertise the address of the VXLAN interface
advertise_addr = "{{ hostvars[inventory_hostname]['vxlan_interface_address'] }}"

# Enable the web interface
ui_config {
  enabled = true
}

# Whether it is running in server mode or not
server = true

# This server expects to be the only one in the cluster.
# Comment this line if this is not a server.
bootstrap_expect = 3
  
addresses {
  # Bind the DNS service to the VXLAN interface
  # We can't bind on 0.0.0.0, because systemd-resolved already listens on 127.0.0.53
  dns = "{{ hostvars[inventory_hostname]['vxlan_interface_address'] }}"
}

ports {
  # Make the DNS service listen on port 53, instead of the default 8600
  dns = 53
}

# List of upstream DNS servers to forward queries to
recursors = ["1.1.1.1", "1.0.0.1"]
