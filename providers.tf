provider "google" {
  project = var.project
  region  = var.region
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.k8s.control_plane_cluster.endpoint}"
    config_path            = "~/.kube/config"
    token                  = data.google_client_config.default.access_token
    client_certificate     = base64decode(module.k8s.control_plane_cluster.primary.master_auth.0.client_certificate)
    client_key             = base64decode(module.k8s.control_plane_cluster.primary.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(module.k8s.control_plane_cluster.primary.master_auth.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = "https://${module.k8s.control_plane_cluster.primary.endpoint}"
  config_path            = "~/.kube/config"
  token                  = data.google_client_config.default.access_token
  client_certificate     = base64decode(module.k8s.control_plane_cluster.primary.master_auth.0.client_certificate)
  client_key             = base64decode(module.k8s.control_plane_cluster.primary.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(module.k8s.control_plane_cluster.primary.master_auth.0.cluster_ca_certificate)
}

provider "kubectl" {
  host                   = "https://${module.k8s.control_plane_cluster.primary.endpoint}"
  config_path            = "~/.kube/config"
  token                  = data.google_client_config.default.access_token
  client_certificate     = base64decode(module.k8s.control_plane_cluster.primary.master_auth.0.client_certificate)
  client_key             = base64decode(module.k8s.control_plane_cluster.primary.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(module.k8s.control_plane_cluster.primary.master_auth.0.cluster_ca_certificate)
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
