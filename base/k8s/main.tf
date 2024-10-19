module "control_plane" {
  source              = "./control-plane"
  project             = var.project
  region              = var.region
  zone                = var.zone
  network_vpc_name    = var.network_vpc_name
  network_subnet_name = var.network_subnet_name
}

module "nodes" {
  source                = "./nodes"
  project               = var.project
  region                = var.region
  zone                  = var.zone
  gke_num_nodes         = var.gke_num_nodes
  control_plane_cluster = module.control_plane.control_plane_cluster
}
