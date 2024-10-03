variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "load_balancer_ip" {
  description = "The external load balancer IP address"
  type        = string
}