variable "kube_config_path" {
  type        = string
  description = "Kube config path"
  default     = "~/.kube/config"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
}

variable "external_static_ip" {
  description = "External Static IP Address"
}
