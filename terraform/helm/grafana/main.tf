provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = "monitoring"
  chart      = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}

resource "kubernetes_manifest" "grafana_ingress" {
  manifest = yamldecode(file("${path.module}/manifests/ingress.yml"))
}