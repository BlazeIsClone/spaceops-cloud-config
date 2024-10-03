provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "traefik" {
  name       = "traefik"
  namespace  = "traefik"
  chart      = "traefik"
  repository = "https://traefik.github.io/charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}