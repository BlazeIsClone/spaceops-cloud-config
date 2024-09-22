# Cloud Config

[![Terraform](https://img.shields.io/badge/terraform-633690.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://developer.hashicorp.com/)

### Prerequisites

- A Google Cloud Platform account. If you do not have a GCP account, create one now. This tutorial can be completed using only the services included in the GCP free tier.
- The gcloud CLI installed locally.
- Terraform 0.15.3+ installed locally.

### Commands

Configure kubectl cluster access:

```bash
gcloud container clusters get-credentials gke-standard-regional-single-zone --region=us-west1
```

Configure Traefik (update service load balancer IP address):

```
kubectl create namespace traefik

cd deploy\prod\treafik

kubectl apply -n traefik -f https://raw.githubusercontent.com/traefik/traefik/v3.1/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml -f https://raw.githubusercontent.com/traefik/traefik/v3.1/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml

kubectl apply -n traefik -f role.yml -f account.yml -f role-binding.yml -f services.yml -f deployment.yml
```

Configure Argo CD:

```bash
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -f deploy/prod/argocd/config.yml

kubectl delete po argocd-server-xxx -n argocd

kubectl get -n argocd secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
