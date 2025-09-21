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