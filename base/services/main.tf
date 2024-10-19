module "prometheus" {
  source             = "./prometheus"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "loki" {
  source             = "./loki"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "tempo" {
  source             = "./tempo"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "grafana" {
  source             = "./grafana"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "traefik" {
  source             = "./traefik"
  load_balancer_ip   = google_compute_address.default.address
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "argocd" {
  source             = "./argocd"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}
