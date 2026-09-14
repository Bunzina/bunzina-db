variable "aws_region" {
  description = "AWS region where the EKS cluster is running."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Base name used for resource identifiers."
  type        = string
  default     = "bunzina"
}

variable "environment" {
  description = "Deployment environment, such as dev or prod."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "prod"], lower(var.environment))
    error_message = "The environment must be either dev or prod."
  }
}

variable "infra_state_bucket" {
  description = "S3 bucket containing the Terraform state for bunzina-infra."
  type        = string
}

variable "infra_state_key" {
  description = "S3 key for the bunzina-infra Terraform state."
  type        = string
  default     = "bunzina/infra/dev/terraform.tfstate"
}

variable "kubernetes_namespace" {
  description = "Kubernetes namespace where PostgreSQL is provisioned."
  type        = string
  default     = "bunzina"
}

variable "storage_class_name" {
  description = "Kubernetes StorageClass used by the PostgreSQL PVC."
  type        = string
  default     = "gp3"
}

variable "postgres_image" {
  description = "PostgreSQL container image."
  type        = string
  default     = "postgres:15"
}

variable "db_username" {
  description = "PostgreSQL user stored in the Kubernetes Secret."
  type        = string
  default     = "bun"
}

variable "db_password" {
  description = "PostgreSQL password supplied through TF_VAR_db_password."
  type        = string
  sensitive   = true
  nullable    = false
}

variable "db_name" {
  description = "Initial database name used by the application."
  type        = string
  default     = "bunzina"
}

variable "storage_size" {
  description = "Persistent volume size for PostgreSQL in GiB."
  type        = number
  default     = 10

  validation {
    condition     = var.storage_size >= 1
    error_message = "The PostgreSQL persistent volume must be at least 1 GiB."
  }
}
