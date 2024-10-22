data "google_container_engine_versions" "gke_version" {
  location       = var.region
  version_prefix = "1.27."
}

resource "google_container_cluster" "primary" {
  name     = "${var.project}-gke-${terraform.workspace}"
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  node_locations           = [var.zone]
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network_vpc_name
  subnetwork = var.network_subnet_name

  # Nerf initial spec
  node_config {
    disk_size_gb = "20"

    kubelet_config {
      cpu_cfs_quota      = "false"
      pod_pids_limit     = 0
      cpu_manager_policy = ""
    }
  }
}
