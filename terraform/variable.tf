variable "region" {
    description = " The AWS region to deploy resources in"
    type = string
    default = "us-east-1"
}

variable "environment_name" {
    description = "name of the environment"
    type        = string
    default     = "innovatemart"
}
variable "mysql_username" {
  description = "Username for the MySQL RDS instance"
  type        = string
}

variable "mysql_password" {
  description = "Password for the MySQL RDS instance"
  type        = string
  sensitive   = true
}

variable "postgresql_username" {
  description = "Username for the PostgreSQL RDS instance"
  type        = string
}

variable "postgresql_password" {
  description = "Password for the PostgreSQL RDS instance"
  type        = string
  sensitive   = true
}


