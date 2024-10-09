resource "helm_release" "grafana" {
  name             = "grafana"
  namespace        = "monitoring"
  chart            = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}

resource "kubectl_manifest" "prometheus_ingress" {
  provider          = kubectl
  for_each          = toset(split("---", file("${abspath(path.module)}/manifests/ingress.yml")))
  yaml_body         = each.value
  server_side_apply = true

  depends_on = [helm_release.grafana]
}
