provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Traefik Deployment
resource "helm_release" "traefik" {
  name       = "traefik"
  namespace  = "traefik"
  chart      = "traefik"
  repository = "https://traefik.github.io/charts"
  create_namespace = true
  values = [file("cluster-spaceops/core/traefik/values.yml")]
}

# Argo CD Deployment
resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  create_namespace = true
  values = [file("cluster-spaceops/core/argocd/values.yml")]
}

resource "kubernetes_manifest" "argocd_ingress" {
  manifest = yamldecode(file("cluster-spaceops/argocd/ingress.yml"))
}

# Grafana Deployment
resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = "monitoring"
  chart      = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  create_namespace = true
  values = [file("cluster-spaceops/core/grafana/values.yml")]
}

resource "kubernetes_manifest" "grafana_ingress" {
  manifest = yamldecode(file("cluster-spaceops/core/grafana/ingress.yml"))
}

# Prometheus Deployment
resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = "monitoring"
  chart      = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  create_namespace = true
  values = [file("cluster-spaceops/core/prometheus/values.yml")]
}

resource "kubernetes_manifest" "prometheus_ingress" {
  manifest = yamldecode(file("cluster-spaceops/core/prometheus/ingress.yml"))
}

# Loki and Promtail Deployment
resource "helm_release" "loki" {
  name       = "loki"
  namespace  = "monitoring"
  chart      = "loki-stack"
  repository = "https://grafana.github.io/helm-charts"
  create_namespace = true
  values = [file("cluster-spaceops/core/loki/values.yml")]
}

resource "kubernetes_manifest" "loki_ingress" {
  manifest = yamldecode(file("cluster-spaceops/core/loki/ingress.yml"))
}