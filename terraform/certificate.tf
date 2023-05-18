resource "cloudflare_certificate_pack" "certificate" {
  lifecycle {
    prevent_destroy = true
  }

  zone_id               = data.cloudflare_zone.zone.id
  type                  = "advanced"
  validation_method     = "txt"
  validity_days         = 365
  certificate_authority = "digicert"

  hosts = concat(
    [
      var.domain,
      format("*.%s", var.domain),
    ],
    [
      for host in var.hosts : format("*.%s.%s", host.name, var.domain)
    ],
    [
      for group in var.groups : format("*.%s.%s", group.name, var.domain)
    ]
  )
}
