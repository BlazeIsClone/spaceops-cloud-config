variable "project" {
  type        = string
  description = "Project name"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "zone" {
  type        = string
  description = "GCP Zone"
}

variable "gke_num_nodes" {
  type        = number
  description = "Number of nodes"
}

variable "network_vpc_name" {
  type        = string
  description = "Virtual Private Cloud Name"
}

variable "network_subnet_name" {
  type        = string
  description = "Virtual Private Cloud Subnet"
}

