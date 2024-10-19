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

variable "network_vpc_name" {
  type        = string
  description = "Virtual Private Cloud Name"
}

variable "network_subnet_name" {
  type        = string
  description = "Virtual Private Cloud Subnet"
}
