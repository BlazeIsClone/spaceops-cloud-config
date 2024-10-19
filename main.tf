data "google_client_config" "default" {}

module "network" {
  source  = "./base/network"
  project = var.project
  region  = var.region
}

module "k8s" {
  source              = "./base/k8s"
  project             = var.project
  region              = var.region
  zone                = var.zone
  gke_num_nodes       = var.gke_num_nodes
  network_vpc_name    = module.network.network_vpc
  network_subnet_name = module.network.network_subnet
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
  external_static_ip   = module.network.network_ip_address
}
