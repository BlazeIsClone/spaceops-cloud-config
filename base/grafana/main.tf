resource "helm_release" "grafana" {
  name             = "grafana"
  namespace        = "monitoring"
  chart            = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}

resource "kubectl_manifest" "grafana_ingress" {
  provider          = kubectl
  for_each          = toset(split("---", file("${abspath(path.module)}/manifests/ingress.yml")))
  yaml_body         = each.value
  server_side_apply = true

  depends_on = [helm_release.grafana]
}

resource "cloudflare_dns_record" "grafana_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "grafana"
  content = var.external_static_ip
  type    = "A"
  ttl     = 1
  proxied = true
}

# resource "grafana_dashboard" "traefik_dashboard" {
#   for_each    = fileset("${var.dashboard_file_path}", "**")
#   config_json = file("${var.dashboard_file_path}/${each.key}")

#   depends_on = [kubectl_manifest.grafana_ingress]
# }


