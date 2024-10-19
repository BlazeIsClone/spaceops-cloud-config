module "network" {
  source  = "./base/network"
  project = var.project
  region  = var.region
}

module "cluster" {
  source        = "./base/cluster"
  project       = var.project
  region        = var.region
  zone          = var.zone
  gke_num_nodes = var.gke_num_nodes
}

module "database" {
  source  = "./base/database"
  project = var.project
  region  = var.region
}

module "prometheus" {
  source             = "./base/services/prometheus"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "loki" {
  source             = "./base/services/loki"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "tempo" {
  source             = "./base/services/tempo"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "grafana" {
  source             = "./base/services/grafana"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "traefik" {
  source             = "./base/services/traefik"
  project            = var.project
  load_balancer_ip   = google_compute_address.default.address
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "argocd" {
  source             = "./base/services/argocd"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}
