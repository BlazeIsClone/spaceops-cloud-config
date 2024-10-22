resource "cloudflare_dns_record" "mission_ctrl_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "mission-ctrl"
  content = var.external_static_ip
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "mission_ctrl_dns_staging" {
  zone_id = var.cloudflare_zone_id
  name    = "mission-ctrl-staging"
  content = var.external_static_ip
  type    = "A"
  ttl     = 1
  proxied = true
}
