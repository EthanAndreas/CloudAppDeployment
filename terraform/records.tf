resource "cloudflare_record" "internal_hosts" {
  for_each = {
    for host in var.hosts : host.name => host
  }

  zone_id = data.cloudflare_zone.zone.id
  name    = format("%s.internal", each.value.name)
  type    = "A"
  value   = each.value.internal_ip
  proxied = false
  ttl     = 300
  comment = format("[cloud-virt] Int. host IP of %s", each.value.name)
}

resource "cloudflare_record" "internal_groups" {
  for_each = {
    for group in var.groups : group.name => group
  }

  zone_id = data.cloudflare_zone.zone.id
  name    = format("%s.internal", each.value.name)
  type    = "A"
  value   = each.value.internal_ip
  proxied = false
  ttl     = 300
  comment = format("[cloud-virt] Int. Nomad/Consul %s", each.value.name)
}


resource "cloudflare_record" "bastion" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "bastion"
  type    = "A"
  value   = var.bastion
  proxied = false
  ttl     = 300
  comment = "[cloud-virt] Int. IP of SSH the bastion"
}

resource "cloudflare_record" "internal_queue" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "queue.internal"
  type    = "CNAME"
  value   = "tunnel.internal.100do.se"
  proxied = false
  ttl     = 300
  comment = "[cloud-virt] RabbitMQ internal IP"
}

resource "cloudflare_record" "queue" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "queue"
  type    = "CNAME"
  value   = cloudflare_tunnel.cloud_virt.cname
  proxied = true
  comment = "[cloud-virt] RabbitMQ UI"
}

resource "cloudflare_record" "hosts" {
  for_each = {
    for host in var.hosts : host.name => host
  }

  zone_id = data.cloudflare_zone.zone.id
  name    = format("%s", each.value.name)
  type    = "CNAME"
  value   = cloudflare_tunnel.cloud_virt.cname
  proxied = true
  comment = format("[cloud-virt] Host %s", each.value.name)
}

resource "cloudflare_record" "hosts_wildcard" {
  for_each = {
    for host in var.hosts : host.name => host
  }

  zone_id = data.cloudflare_zone.zone.id
  name    = format("*.%s", each.value.name)
  type    = "CNAME"
  value   = cloudflare_tunnel.cloud_virt.cname
  proxied = true
  comment = format("[cloud-virt] Host %s", each.value.name)
}


resource "cloudflare_record" "floating_ips" {
  for_each = {
    for group in var.groups : group.name => group
  }

  zone_id = data.cloudflare_zone.zone.id
  type    = "CNAME"
  name    = each.value.name
  value   = cloudflare_tunnel.cloud_virt.cname
  proxied = true
  comment = format("[cloud-virt] Floating IP group %s", each.value.name)
}

resource "cloudflare_record" "floating_ips_wildcard" {
  for_each = {
    for group in var.groups : group.name => group
  }

  zone_id = data.cloudflare_zone.zone.id
  type    = "CNAME"
  name    = format("*.%s", each.value.name)
  value   = cloudflare_tunnel.cloud_virt.cname
  proxied = true
  comment = format("[cloud-virt] Floating IP group %s", each.value.name)
}

resource "cloudflare_record" "nomad" {
  for_each = {
    for group in var.groups : group.name => group
  }

  zone_id = data.cloudflare_zone.zone.id
  type    = "CNAME"
  name    = format("nomad-%s", each.value.name)
  value   = cloudflare_tunnel.cloud_virt.cname
  proxied = true
  comment = format("[cloud-virt] Nomad group %s", each.value.name)
}

resource "cloudflare_record" "consul" {
  for_each = {
    for group in var.groups : group.name => group
  }

  zone_id = data.cloudflare_zone.zone.id
  type    = "CNAME"
  name    = format("consul-%s", each.value.name)
  value   = cloudflare_tunnel.cloud_virt.cname
  proxied = true
  comment = format("[cloud-virt] Consul group %s", each.value.name)
}
