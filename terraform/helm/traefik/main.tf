resource "helm_release" "traefik" {
  name             = "traefik"
  namespace        = "traefik"
  chart            = "traefik"
  repository       = "https://traefik.github.io/charts"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]

  set {
    name  = "service.loadBalancerIP"
    value = var.load_balancer_ip
  }
}
