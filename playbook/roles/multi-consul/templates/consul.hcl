{{ ansible_managed | comment }}

node_name = "{{ instance_name }}"
data_dir = "/opt/consul/{{ instance_name }}"
bind_addr = "{{ instance_address }}"
client_addr = "{{ instance_address }}"
advertise_addr = "{{ instance_address }}"

ui_config {
  enabled = true
}

telemetry {
  prometheus_retention_time = "360h"
}

server = true
bootstrap_expect = 1
