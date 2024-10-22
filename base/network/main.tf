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
