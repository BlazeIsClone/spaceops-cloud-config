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

Configure Traefik:

```
cd deploy\prod\treafik

kubectl apply -f 00-role.yml -f 00-account.yml -f 01-role-binding.yml -f 02-services.yml -f 03-deployment.yml
```

ArgoCD:

```bash
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
