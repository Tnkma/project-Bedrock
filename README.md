🚀 Project Bedrock – InnovateMart EKS Deployment

This repository contains the infrastructure and deployment code for Project Bedrock, InnovateMart’s inaugural production-grade Kubernetes environment on AWS.

The goal is to deploy the Retail Store Sample Application on Amazon EKS using Infrastructure as Code (Terraform), with secure developer access and automated CI/CD pipelines.

📌 Architecture Overview

Provisioned via Terraform:

VPC with public and private subnets.

Amazon EKS Cluster with managed node groups.

IAM Roles & Policies (least-privilege principle for cluster and nodes).

RDS Databases (PostgreSQL & MySQL) for Orders and Catalog services.

DynamoDB for Carts service persistence.

AWS Load Balancer Controller with ALB Ingress, Route53, and ACM for HTTPS-enabled public access.

Developer IAM User with read-only permissions for observability (logs, pod status, services).

CI/CD Pipelines using GitHub Actions for Terraform validation, planning, and apply.

kubectl for Kubernetes cluster management.

⚙️ Deployment Guide
1. Prerequisites

AWS account with administrative access.

AWS CLI installed and configured.

Terraform installed (>=1.0).

kubectl installed.

GitHub Actions enabled (for CI/CD automation).

2. Setup AWS Credentials
aws iam create-access-key --user-name <your-preferred-name>
aws configure --profile <your-preferred-name>

3. Clone the Repository
git clone <your-repo-url>
cd project-Bedrock/terraform

4. Provision Infrastructure with Terraform
terraform init
terraform validate
terraform plan
terraform apply

5. Configure kubectl for EKS
aws eks --region us-east-1 update-kubeconfig \
  --name innovatemart-eks-cluster \
  --profile <your-preferred-name>

6. Deploy Kubernetes Resources

At the repository root:

kubectl apply -f kubernetes.yaml

7. Create Database Secrets in Kubernetes
# Orders service DB secret
kubectl create secret generic orders-db-secret \
  --from-literal=DB_HOST=orders-db-instance.cepy44isyzsb.us-east-1.rds.amazonaws.com \
  --from-literal=DB_USER=orders_user \
  --from-literal=DB_PASSWORD=SuperSecret123! \
  --from-literal=DB_NAME=order_db

# Catalog service DB secret
kubectl create secret generic catalog-db-secret \
  --from-literal=DB_HOST=catalog-db-instance.cepy44isyzsb.us-east-1.rds.amazonaws.com \
  --from-literal=DB_USER=catalog_user \
  --from-literal=DB_PASSWORD=SuperSecret456! \
  --from-literal=DB_NAME=catalog_db

8. Verify Deployment
kubectl get pods
kubectl get svc

9. Developer Access (Read-Only)

For developers who need observability without modification privileges:

aws iam create-access-key --user-name developer
aws configure --profile developer

aws eks --region us-east-1 update-kubeconfig \
  --name innovatemart-eks-cluster \
  --profile developer


Developers can:

View logs (kubectl logs).

Describe pods (kubectl describe pod <pod-name>).

Check service status (kubectl get svc).

📂 Repository Structure
project-Bedrock/
│── terraform/          # Terraform modules for AWS infrastructure
│── kubernetes.yaml     # Kubernetes manifests for app deployment
│── .github/workflows/  # GitHub Actions CI/CD pipelines
│── README.md           # Deployment documentation

✅ Features

Automated Infrastructure: Fully provisioned via Terraform.

Production-Ready EKS: Secure, scalable Kubernetes cluster on AWS.

Managed Persistence: RDS for relational services, DynamoDB for carts.

Secure Access Control: IAM roles with least-privilege enforcement.

Continuous Delivery: GitHub Actions pipeline for Terraform automation.

Developer-Friendly: Observability access without risk of resource modification.

📖 Notes

Replace placeholder values (<your-repo-url>, <your-preferred-name>) with actual values.

Update database credentials and secrets for production use.

Ensure DNS (Route53) and ACM certificates are configured for HTTPS ingress.

# Notes & Best Practices

Replace all placeholders (<...>) before running commands.

Do not commit secrets or private keys to source control. Use AWS Secrets Manager or GitHub Actions secrets.

Use separate AWS accounts/environments for dev/staging/prod.

Consider enabling Terraform state locking (via S3 + DynamoDB) and remote state storage.

Monitor costs: RDS, EKS, ALBs can be significant. Tear down resources when not in use.

Use IAM least-privilege and enable RBAC inside Kubernetes.