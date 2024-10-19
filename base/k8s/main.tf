module "control_plane" {
  source  = "./control-plane"
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "nodes" {
  source        = "./nodes"
  project       = var.project
  region        = var.region
  zone          = var.zone
  gke_num_nodes = var.gke_num_nodes
}
