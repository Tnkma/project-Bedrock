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
output "cluster_arn" {
  description = " The Amazon Resource Name (ARN) of the EKS cluster"
  value       = module.eks.cluster_arn
}
output "node_security_group_id" {
  description = "Security group ID of the EKS managed node group"
  value       = module.eks.node_security_group_id
}
output "managed_node_groups_autoscaling_group_names" {
  description = "List of names of Auto Scaling groups created by EKS managed node groups"
  value       = module.eks.eks_managed_node_groups_autoscaling_group_names
}