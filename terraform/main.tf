# Terraform backend configuration
terraform {
  backend "s3" {
    bucket         = "bedrock-terraform-tfstate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.0"
    }
  }
}

provider "aws" {
    region = var.region
}

module "vpc" {
    source = "./modules/vpc"
    region = var.region
}
module "eks" {
    source = "./modules/eks"
    region = var.region

    vpc_id         = module.vpc.vpc_id
    subnet_ids     = module.vpc.private_subnet_ids
    developer_user_arn = var.developer_user_arn
}

# --- Defines the dev-user and their AWS-level permissions ---
resource "aws_iam_user" "developer" {
  name = "dev-user"
  force_destroy = true
  tags = {
    Project = "Bedrock"
  }
}
resource "aws_iam_policy" "developer_eks_describe" {
  name   = "EKS-DescribeCluster-Policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["eks:DescribeCluster"]
        Effect   = "Allow"
        Resource = module.eks.cluster_arn
      },
    ]
  })
}
# Attaches and detaches the above policy to the developer IAM user so we can clean properly
resource "aws_iam_user_policy_attachment" "developer_attach" {
  user       = aws_iam_user.developer.name
  policy_arn = aws_iam_policy.developer_eks_describe.arn

  depends_on = [aws_iam_policy.developer_eks_describe]
}