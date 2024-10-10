variable "dashboard_file_path" {
  description = "Grafana dashboard file local path"
  type        = string
  default     = "dashboards/"
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
}

variable "external_static_ip" {
  description = "The external static IP address"
  type        = string
}

