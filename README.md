# Cloud Config

[![Terraform](https://img.shields.io/badge/terraform-633690.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://developer.hashicorp.com/)

### Prerequisites

- A Google Cloud Platform account. If you do not have a GCP account, create one now. This tutorial can be completed using only the services included in the GCP free tier.
- The gcloud CLI installed locally.
- Terraform 0.15.3+ installed locally.

First authenticate kubectl for cluster access:

### Provision Cloud Infrastructure

Terraform create resources:

```
terraform apply
```

### Provision K8s Cluster

```bash
gcloud container clusters get-credentials gke-standard-regional-single-zone --region=us-west1
```

Configure Traefik (update service load balancer IP address):

```bash
helm upgrade --install --create-namespace --namespace=traefik \
    --repo https://traefik.github.io/charts \
    -f deploy/prod/traefik/values.yml traefik traefik
```

Configure Argo CD:

```bash
 helm upgrade --install --create-namespace --namespace=argocd \
    --repo https://argoproj.github.io/argo-helm \
    -f deploy/prod/argocd/values.yml argocd argo-cd

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
