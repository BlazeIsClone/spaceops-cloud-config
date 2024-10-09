# Helm Provider
variable "kube_config_path" {
  type        = string
  description = "Kube config path"
  default     = "~/.kube/config"
}

# Google Provider
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

# Kubernetes
variable "load_balancer_ip" {}

