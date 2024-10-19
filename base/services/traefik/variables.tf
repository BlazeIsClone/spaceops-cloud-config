variable "load_balancer_ip" {
  description = "The external load balancer IP address"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
}

variable "external_static_ip" {
  description = "The external static IP address"
  type        = string
}
