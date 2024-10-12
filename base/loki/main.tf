resource "helm_release" "loki" {
  name             = "loki"
  namespace        = "monitoring"
  chart            = "loki-stack"
  repository       = "https://grafana.github.io/helm-charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]

  set {
    name  = "loki.image.tag"
    value = "2.9.3"
  }
}

resource "kubectl_manifest" "loki_ingress" {
  for_each          = toset(split("---", file("${abspath(path.module)}/manifests/ingress.yml")))
  yaml_body         = each.value
  server_side_apply = true

  depends_on = [helm_release.loki]
}

resource "cloudflare_dns_record" "loki_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "loki"
  content = var.external_static_ip
  type    = "A"
  ttl     = 1
  proxied = true
}
