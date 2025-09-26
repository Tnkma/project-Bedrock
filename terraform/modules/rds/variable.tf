variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "mysql_password" {
    description = "The password for the MySQL database"
    type        = string
    sensitive   = true
}
variable "mysql_username" {
    description = "The username for the MySQL database"
    type        = string
}

variable "postgresql_password" {
    description = "The password for the PostgreSQL database"
    type        = string
    sensitive   = true
}
variable "postgresql_username" {
    description = "The username for the PostgreSQL database"
    type        = string
}

variable "vpc_id" {
  description = "VPC ID where RDS instances will be deployed"
  type        = string
}
variable "private_subnets" {
  description = "Private subnet IDs where RDS instances will be deployed"
  type        = list(string)
}
variable "eks_node_sg_id" {
  description = "Security group ID for EKS worker nodes"
  type        = string
}
