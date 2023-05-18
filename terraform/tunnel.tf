variable "tunnel_secret" {
  type      = string
  sensitive = true
}

resource "cloudflare_tunnel" "cloud_virt" {
  account_id = var.account_id
  name       = "cloud-virt"
  secret     = var.tunnel_secret
}

resource "cloudflare_tunnel_config" "cloud_virt" {
  account_id = var.account_id
  tunnel_id  = cloudflare_tunnel.cloud_virt.id

  config {
    ingress_rule {
      hostname = format("queue.%s", var.domain)
      #service  = "http://127.0.0.1:15672"
      service = format("http://%s:15672", var.hosts[0].vxlan_ip)
    }

    dynamic "ingress_rule" {
      for_each = var.groups

      content {
        hostname = format("%s.%s", ingress_rule.value.name, var.domain)
        service  = format("http://%s:8081", ingress_rule.value.floating_ip)
      }
    }

    dynamic "ingress_rule" {
      for_each = var.groups

      content {
        hostname = format("*.%s.%s", ingress_rule.value.name, var.domain)
        service  = format("http://%s:8081", ingress_rule.value.floating_ip)
      }
    }

    dynamic "ingress_rule" {
      for_each = var.groups

      content {
        hostname = format("nomad-%s.%s", ingress_rule.value.name, var.domain)
        service  = format("http://%s:4646", ingress_rule.value.internal_ip)
      }
    }

    dynamic "ingress_rule" {
      for_each = var.groups

      content {
        hostname = format("consul-%s.%s", ingress_rule.value.name, var.domain)
        service  = format("http://%s:8500", ingress_rule.value.internal_ip)
      }
    }

    dynamic "ingress_rule" {
      for_each = var.hosts

      content {
        hostname = format("%s.%s", ingress_rule.value.name, var.domain)
        service  = format("http://%s:8080", ingress_rule.value.vxlan_ip)
      }
    }

    dynamic "ingress_rule" {
      for_each = var.hosts

      content {
        hostname = format("*.%s.%s", ingress_rule.value.name, var.domain)
        service  = format("http://%s:8080", ingress_rule.value.vxlan_ip)
      }
    }

    ingress_rule {
      service = "http_status:404"
    }
  }
}

output "tunnel_id" {
  value = cloudflare_tunnel.cloud_virt.id
}

output "tunnel_token" {
  value     = cloudflare_tunnel.cloud_virt.tunnel_token
  sensitive = true
}
