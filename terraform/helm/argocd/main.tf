provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}

resource "kubernetes_manifest" "argocd_ingress" {
  manifest = yamldecode(file("${path.module}/manifests/ingress.yml"))
}