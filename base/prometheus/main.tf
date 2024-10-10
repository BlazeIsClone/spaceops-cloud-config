resource "helm_release" "prometheus" {
  name             = "prometheus"
  namespace        = "monitoring"
  chart            = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}

resource "kubectl_manifest" "prometheus_ingress" {
  for_each          = toset(split("---", file("${abspath(path.module)}/manifests/ingress.yml")))
  yaml_body         = each.value
  server_side_apply = true

  depends_on = [helm_release.prometheus]
}

resource "cloudflare_dns_record" "prometheus_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "prometheus"
  content = var.external_static_ip
  type    = "A"
  ttl     = 1
  proxied = true
}
