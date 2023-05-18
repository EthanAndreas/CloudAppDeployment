{{ ansible_managed | comment }}

# Group name
datacenter = "{{ main_instance_group.name }}"

# Save the persistent data to /opt/consul. This directory is owned by the `consul` user.
data_dir = "/opt/consul"
node_name = "{{ inventory_hostname }}"

# Allow clients to connect from any interface
client_addr = "0.0.0.0"

# Advertise the address of the VXLAN interface
advertise_addr = "{{ vxlan_interface_address | ansible.utils.ipaddr('address') }}"

# Enable the web interface
ui_config {
  enabled = true
}

# Whether it is running in server mode or not
server = true

# This server expects to be the only one in the cluster.
# Comment this line if this is not a server.
bootstrap_expect = 1

addresses {
  # Bind the DNS service to the VXLAN interface
  # We can't bind on 0.0.0.0, because systemd-resolved already listens on 127.0.0.53
  dns = "{{ vxlan_interface_address | ansible.utils.ipaddr('address')}}"
}

ports {
  # Make the DNS service listen on port 53, instead of the default 8600
  dns = 53
}

# List of upstream DNS servers to forward queries to
recursors = [{% for r in recursors %}"{{ r }}"{{ ", " if not loop.last else "" }}{% endfor %}]
