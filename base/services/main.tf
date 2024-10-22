module "prometheus" {
  source             = "./prometheus"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = var.external_static_ip
}

module "loki" {
  source             = "./loki"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = var.external_static_ip
}

module "tempo" {
  source             = "./tempo"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = var.external_static_ip
}

module "grafana" {
  source             = "./grafana"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = var.external_static_ip
}

module "traefik" {
  source             = "./traefik"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = var.external_static_ip
}

module "argocd" {
  source             = "./argocd"
  cloudflare_zone_id = var.cloudflare_zone_id
  external_static_ip = var.external_static_ip
}
