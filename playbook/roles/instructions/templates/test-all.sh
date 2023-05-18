#!/bin/sh

for i in {{ instances | join(" ") }}; do
  CONSUL_HTTP_ADDR=https://consul-$i.100do.se consul members
  NOMAD_ADDR=https://nomad-$i.100do.se nomad server members
done
