resource "helm_release" "tempo" {
  name             = "tempo"
  namespace        = "monitoring"
  chart            = "tempo"
  repository       = "https://grafana.github.io/helm-charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}
