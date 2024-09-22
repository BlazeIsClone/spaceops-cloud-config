terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project
}

resource "google_compute_address" "default" {
  name         = "spaceops-ipv4"
  address_type = "EXTERNAL"
  region       = var.region
}

resource "google_container_cluster" "default" {
  name               = "gke-standard-regional-single-zone"
  location           = var.region
  node_locations     = ["us-west1-c"]
  initial_node_count = 2
}