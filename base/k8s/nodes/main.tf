resource "google_container_node_pool" "primary_nodes" {
  name     = var.control_plane_cluster.name
  cluster  = var.control_plane_cluster.name
  location = var.region

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

    kubelet_config {
      cpu_cfs_quota      = "false"
      pod_pids_limit     = 0
      cpu_manager_policy = ""
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
