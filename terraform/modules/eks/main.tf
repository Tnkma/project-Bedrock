module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.3.1"

  name    = var.cluster_name
  kubernetes_version = var.cluster_version


  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

  endpoint_public_access = true
  # Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  
  # Trying to keep things minimal for now instead of using compute_config
  eks_managed_node_groups = {
    eks_nodes = {
      ami_type       = "AL2023_x86_64_STANDARD"
      desired_size = 2
      max_size     = 3
      min_size     = 1

      instance_types = ["t3.medium"]

      # key_name = "eks-keypair"
      tags = {
        terraform = "true"
        project   = "Bedrock"
      }
    }
  }

  # creates and attach an IAM role to the cluster for our developer user
  access_entries = {
    # An entry for our read-only developer user
    developer_readonly = {
      principal_arn = var.developer_user_arn 

      # Associate the user with a pre-built AWS EKS access policy
      policy_associations = {
        # This policy grants cluster-wide read-only access
        view_only = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}