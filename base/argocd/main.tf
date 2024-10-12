resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  create_namespace = true

  values = [file("${path.module}/manifests/values.yml")]
}

resource "kubectl_manifest" "argocd_ingress" {
  provider          = kubectl
  for_each          = toset(split("---", file("${abspath(path.module)}/manifests/ingress.yml")))
  yaml_body         = each.value
  server_side_apply = true

  depends_on = [helm_release.argocd]
}

resource "cloudflare_dns_record" "argocd_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "argocd"
  content = var.external_static_ip
  type    = "A"
  ttl     = 1
  proxied = true
}
