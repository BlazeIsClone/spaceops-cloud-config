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

resource "google_compute_address" "default" {
  name         = "spaceops-ipv4"
  address_type = "EXTERNAL"
  region       = "us-west1"
}

resource "google_container_cluster" "default" {
  name               = "gke-standard-regional-single-zone"
  location           = "us-west1"
  node_locations     = ["us-west1-c"]
  initial_node_count = 2
}