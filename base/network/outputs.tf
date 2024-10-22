output "network_ip_address" {
  value = google_compute_address.default.address
}

output "network_vpc" {
  value = google_compute_network.vpc.name
}

output "network_subnet" {
  value = google_compute_subnetwork.subnet.name
}
