provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "tempo" {
  name       = "tempo"
  namespace  = "monitoring"
  chart      = "tempo"
  repository = "https://prometheus-community.github.io/helm-charts"
  create_namespace = true

  values = [file("${path.module}/values.yml")]
}

resource "kubernetes_manifest" "tempo_ingress" {
  manifest = yamldecode(file("${path.module}/ingress.yml"))
}