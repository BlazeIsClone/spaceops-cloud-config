resource "helm_release" "tempo" {
  name             = "tempo"
  namespace        = "monitoring"
  chart            = "tempo"
  repository       = "https://prometheus-community.github.io/helm-charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}

resource "kubectl_manifest" "tempo_ingress" {
  provider          = kubectl
  for_each          = toset(split("---", file("${abspath(path.module)}/manifests/ingress.yml")))
  yaml_body         = each.value
  server_side_apply = true

  depends_on = [helm_release.tempo]
}

resource "cloudflare_dns_record" "tempo_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "tempo"
  content = var.external_static_ip
  type    = "A"
  ttl     = 1
  proxied = true
}
