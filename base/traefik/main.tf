resource "helm_release" "traefik" {
  name             = "traefik"
  namespace        = "traefik"
  chart            = "traefik"
  repository       = "https://traefik.github.io/charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]

  set {
    name  = "service.spec.loadBalancerIP"
    value = var.load_balancer_ip
  }
}

resource "cloudflare_dns_record" "traefik_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "traefik"
  content = var.external_static_ip
  type    = "A"
  ttl     = 1
  proxied = true
}
