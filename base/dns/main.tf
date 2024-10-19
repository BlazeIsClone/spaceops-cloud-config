resource "cloudflare_dns_record" "mission_ctrl_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "mission-ctrl"
  content = google_compute_address.default.address
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "mission-ctrl_dns_staging" {
  zone_id = var.cloudflare_zone_id
  name    = "mission-ctrl-staging"
  content = google_compute_address.default.address
  type    = "A"
  ttl     = 1
  proxied = true
}
