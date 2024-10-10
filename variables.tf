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

# Grafana
variable "grafana_url" {
  description = "Grafana dashboard URL"
}

variable "grafana_api_token" {
  description = "Grafana API Token"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
}
