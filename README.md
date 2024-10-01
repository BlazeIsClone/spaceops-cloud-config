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
    -f cluster-spaceops/core/traefik/values.yml traefik traefik
```

Configure Argo CD:

```bash
 helm upgrade --install --create-namespace --namespace=argocd \
    --repo https://argoproj.github.io/argo-helm \
    -f cluster-spaceops/core/argocd/values.yml argocd argo-cd

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

kubectl -n argocd apply cluster-spaceops/argocd/ingress.yml
```

Grafana:

```bash
helm upgrade --install --create-namespace --namespace=monitoring \
    --repo https://grafana.github.io/helm-charts \
    -f cluster-spaceops/core/grafana/values.yml grafana grafana

kubectl -n monitoring apply -f cluster-spaceops/core/grafana/ingress.yml
```

Prometheus:

```bash
helm upgrade --install --create-namespace --namespace=monitoring \
    --repo https://prometheus-community.github.io/helm-charts \
    -f cluster-spaceops/core/prometheus/values.yml prometheus prometheus

kubectl -n monitoring apply -f cluster-spaceops/core/prometheus/ingress.yml
```

Loki and Promtail:

```bash
helm upgrade --install --create-namespace --namespace=monitoring \
    --repo https://grafana.github.io/helm-charts \
    -f cluster-spaceops/core/loki/values.yml loki loki-stack

helm upgrade --install loki --namespace=monitoring grafana/loki-stack \
    --set loki.image.tag=2.9.3 -f cluster-spaceops/core/loki/values.yml

kubectl -n monitoring apply -f cluster-spaceops/core/loki/ingress.yml
```

### Resources

[Grafana Dashboards](https://github.com/dotdc/grafana-dashboards-kubernetes)
