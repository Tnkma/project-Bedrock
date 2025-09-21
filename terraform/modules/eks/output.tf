output "cluster_name" {
    description = "The name of the cluster"
    value = module.eks.cluster_name
}
output "cluster_security_group_id" {
    description = "The security group ID for the EKS cluster"
    value = module.eks.cluster_security_group_id
}
output "cluster_endpoint" {
  description = "EKS cluster endpoint for API access"
  value       = module.eks.cluster_endpoint
}
