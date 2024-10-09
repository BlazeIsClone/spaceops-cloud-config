resource "helm_release" "tempo" {
  name             = "tempo"
  namespace        = "monitoring"
  chart            = "tempo"
  repository       = "https://prometheus-community.github.io/helm-charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}

resource "kubectl_manifest" "prometheus_ingress" {
  provider          = kubectl
  for_each          = toset(split("---", file("${abspath(path.module)}/manifests/ingress.yml")))
  yaml_body         = each.value
  server_side_apply = true

  depends_on = [helm_release.tempo]
}
