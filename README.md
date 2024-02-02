# Portfolio-Infra

## Project Overview

This repo is a part of 3 repositories for deploying a blog application with a database using ArgoCD app-of-apps on AWS EKS using Terraform.

### Portfolio-app at https://github.com/liormilliger/Portfolio-app.git

with app files, Jenkinsfile for CI, Dockerfiles and docker-compose file for local testing

### Portfolio-config at https://github.com/liormilliger/Portfolio-config.git

with kubernetes configuration files

## About

Portfolio-infra is responsible for setting up and managing the infrastructure of our portfolio project using Terraform.
This includes provisioning an AWS VPC, an EKS cluster with 3 nodes, and initializing Argo CD via a Helm chart.
This project uses modular Terraform scripts for scalable and reusable infrastructure as code.

## Infrastructure Architecture & Components

![infra-Arch](https://github.com/liormilliger/Portfolio-infra/assets/64707466/bdb3828a-a1ae-4ffa-bcfb-a2eb5178e17a)

- **AWS VPC**: Virtual Private Cloud setup for network isolation, with 3 public subnets for high-availability
- **EKS Cluster**: Elastic Kubernetes Service with 3 nodes to manage our containerized applications, and support addons for networking, persistent-volume-claims and secure communication
- **Argo CD**: Continuous deployment tool set up through a Helm chart, configured to listen to Portfolio-config repo.
- **Optional**: Launching EC2 instance with configured with Jenkins (hashed) with n AMI created from a snapshot

## Prerequisites

Before you begin, ensure you have the following:
- Terraform latest version installed
- AWS account
- AWS CLI configured with appropriate credentials
- S3 bucket with /data directory for storing terraform.tfstate file

## Installation and Setup

1. **Initialize Terraform**: Run `terraform init` to initialize the working directory.
2. **Plan Deployment**: Execute `terraform plan` to review the infrastructure changes.
3. **Apply Configuration**: Apply the configuration with `terraform apply`.

## Usage

After setting up the infrastructure, use the following commands for common tasks:
- `terraform plan`: Plan your changes.
- `terraform apply`: Apply your changes.
- `terraform destroy`: Remove all resources created by Terraform.

## Terraform Modules - File Structure
```
.
├── compute
│   ├── compute.tf
│   └── variables.tf
├── eks
│   ├── addons.tf
│   ├── cluster.tf
│   ├── helm.tf
│   ├── nodes.tf
│   ├── oidc.tf
│   ├── outputs.tf
│   ├── secrets.tf
│   └── variables.tf
├── files
│   ├── app-of-apps.yaml
│   ├── fluentd-cm-GPT.yaml
│   ├── prometheus-service-monitor.yaml
│   └── storage-class-csi.yaml
├── files.tf
├── infra-Arch
├── main.tf
├── network
│   ├── network.tf
│   ├── outputs.tf
│   └── variables.tf
├── outputs.tf
├── providers.tf
├── security
│   ├── outputs.tf
│   ├── security.tf
│   └── variables.tf
└── variables.tf
```

**compute module**
 
- Contains EC2 as Jenkins server with AMI snapshot of jenkins installed and configured

**eks module**

- Contains EKS components of cluster, nodes, helm deployment for ArgoCD and AWS-CSI-EBS-Driver, secure communications and addons

**files module**

- Contain k8s components required for the applications deployed by ArgoCD

**security module**

- Creates a Security Group designated for the Jenkins instance


## Integration with Argo CD

Argo CD is deployed using a Helm chart and is configured to monitor the `Portfolio-Config` repo for application deployment configurations.

## Contributing

We welcome contributions! Please read our contributing guidelines for how to propose changes.

## License

This project is licensed under the [MIT License](LICENSE).
