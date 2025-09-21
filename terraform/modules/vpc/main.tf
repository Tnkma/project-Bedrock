# --------------------------vpc module--------------------------

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "6.0.1"

    name = "innovatemart-vpc"
    cidr = "10.0.0.0/16"

    azs = ["${var.region}a", "${var.region}b", "${var.region}c"]

    public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

    enable_nat_gateway = true
    single_nat_gateway = true

    public_subnet_tags = {
    "kubernetes.io/cluster/innovatemart-cluster" = "shared"
    "kubernetes.io/role/elb"                     = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/innovatemart-cluster" = "shared"
    "kubernetes.io/role/internal-elb"            = "1"
  }

    tags = {
        terraform   = "true"
        project     = "Bedrock"
    }
}