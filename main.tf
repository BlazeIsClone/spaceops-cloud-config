module "network" {
  source  = "./base/network"
  project = var.project
  region  = var.region
}

module "k8s" {
  source        = "./base/k8s"
  project       = var.project
  region        = var.region
  zone          = var.zone
  gke_num_nodes = var.gke_num_nodes
}

module "databases" {
  source  = "./base/databases"
  project = var.project
  region  = var.region
}

module "services" {
  source               = "./base/services"
  cloudflare_api_token = var.cloudflare_api_token
  cloudflare_zone_id   = var.cloudflare_zone_id
  kube_config_path     = var.kube_config_path
}
