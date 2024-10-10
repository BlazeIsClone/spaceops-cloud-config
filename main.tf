data "google_client_config" "default" {}

data "google_container_engine_versions" "gke_version" {
  location       = var.region
  version_prefix = "1.27."
}

# VPC Network
resource "google_compute_address" "default" {
  name         = "spaceops-ipv4"
  address_type = "EXTERNAL"
  region       = var.region
}

resource "google_compute_network" "vpc" {
  name                    = "${var.project}-vpc-${terraform.workspace}"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project}-subnet-${terraform.workspace}"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

# Kubernetes Engine
resource "google_container_cluster" "primary" {
  name     = "${var.project}-gke-${terraform.workspace}"
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  node_locations           = [var.zone]
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  depends_on = [
    google_compute_network.vpc,
    google_compute_subnetwork.subnet
  ]

  # Nerf initial spec
  node_config {
    disk_size_gb = "20"
  }
}

# Compute Engine Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.primary.name
  location = var.region
  cluster  = google_container_cluster.primary.name

  node_locations = [var.zone]
  node_count     = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project
    }

    preemptible  = false
    disk_type    = "pd-standard"
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project}-gke-${terraform.workspace}"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  depends_on = [google_container_cluster.primary]
}

module "traefik" {
  source             = "./base/traefik"
  project            = var.project
  load_balancer_ip   = google_compute_address.default.address
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "argocd" {
  source             = "./base/argocd"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "grafana" {
  source             = "./base/grafana"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "prometheus" {
  source             = "./base/prometheus"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

module "loki" {
  source             = "./base/loki"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = google_compute_address.default.address

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}

# module "tempo" {
#   source  = "./base/tempo"
#   cloudflare_zone_id = var.cloudflare_zone_id
#   external_static_ip = google_compute_address.default.address

#   depends_on = [
#     google_container_node_pool.primary_nodes
#   ]
# }
