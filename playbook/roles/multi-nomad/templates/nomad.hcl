{{ ansible_managed | comment }}

data_dir = "/opt/nomad/{{ instance_name }}"

bind_addr = "{{ instance_address }}"

server {
  enabled = true
  bootstrap_expect = 1
}

telemetry {
  publish_allocation_metrics = true
  publish_node_metrics       = true
  datadog_address = "localhost:8125"
  datadog_tags = ["service:{{ instance_name }}"]
  disable_hostname = true
  collection_interval = "10s"
}

consul {
  address = "{{ instance_address }}:8500"
}
