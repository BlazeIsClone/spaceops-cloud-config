terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = "spaceops"
}

resource "google_compute_global_address" "default" {
  name         = "spaceops-mission-ctrl-ipv4"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}

# [START gke_standard_regional_single_zone]
resource "google_container_cluster" "default" {
  name               = "gke-standard-regional-single-zone"
  location           = "us-west1"
  node_locations     = ["us-west1-c"]
  initial_node_count = 2
}
# [END gke_standard_regional_single_zone]