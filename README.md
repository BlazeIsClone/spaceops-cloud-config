# Cloud Config

[![Terraform](https://img.shields.io/badge/terraform-633690.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://developer.hashicorp.com/)

### Prerequisites

- A Google Cloud Platform account. If you do not have a GCP account, create one now. This tutorial can be completed using only the services included in the GCP free tier.
- The gcloud CLI installed locally.
- Terraform 0.15.3+ installed locally.

### Provision Cloud Infrastructure

First authenticate kubectl for cluster access:

```bash
gcloud container clusters get-credentials gke-standard-regional-single-zone --region=us-west1
```

Terraform set variables:

```bash
touch terraform.tfvars
```

Terraform create resources:

```
terraform plan
terraform apply
```

Terraform destroy resources:

```
terraform destroy
```

### Dashboards

[Grafana](https://github.com/dotdc/grafana-dashboards-kubernetes)

[Traefik](https://grafana.com/grafana/dashboards/17346-traefik-official-standalone-dashboard/)

[ArgoCD](https://grafana.com/grafana/dashboards/14584-argocd/)
