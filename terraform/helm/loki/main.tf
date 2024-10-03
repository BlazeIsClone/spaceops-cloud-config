provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "loki" {
  name       = "loki"
  namespace  = "monitoring"
  chart      = "loki-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}

resource "kubernetes_manifest" "loki_ingress" {
  manifest = yamldecode(file("${path.module}/manifests/ingress.yml"))
}