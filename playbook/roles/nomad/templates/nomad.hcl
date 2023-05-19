{{ ansible_managed | comment }}

# Group name
datacenter = "gare-centrale"

# Save the persistent data to /opt/nomad
data_dir = "/opt/nomad"
node_name = "{{ inventory_hostname }}"

# Allow clients to connect from any interface
bind_addr = "0.0.0.0"

advertise {
  # We explicitely advertise the IP on the vxlan interface
  http = "{{ hostvars[inventory_hostname]['vxlan_interface_address'] }}"
  rpc = "{{ hostvars[inventory_hostname]['vxlan_interface_address'] }}"
  serf = "{{ hostvars[inventory_hostname]['vxlan_interface_address'] }}"
}

# This node is a server, and expects to be the only server in the cluster
server {
  enabled = true
  bootstrap_expect = 1
}

# This node is not running jobs
client {
  enabled = true
}

# Connect to the local Consul agent
consul {
  address = "127.0.0.1:8500"
}
