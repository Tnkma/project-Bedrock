terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
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
    developer_user_arn = aws_iam_user.developer.arn
}
resource "aws_iam_user" "developer" {
  name = "dev-user"
  tags = {
    Project = "Bedrock"
  }
}