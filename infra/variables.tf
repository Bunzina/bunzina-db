variable "aws_region" {
  description = "AWS region where the RDS instance will be created."
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

variable "vpc_id" {
  description = "VPC ID where the RDS instance will be provisioned."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs used by the DB subnet group."
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR ranges allowed to reach PostgreSQL on TCP/5432."
  type        = list(string)
  default     = []
}

variable "allowed_security_group_ids" {
  description = "Security groups allowed to reach PostgreSQL on TCP/5432."
  type        = list(string)
  default     = []
}

variable "db_username" {
  description = "Master database user for PostgreSQL."
  type        = string
  default     = "bun"
}

variable "db_name" {
  description = "Initial database name used by the application."
  type        = string
  default     = "bunzina"
}

variable "instance_class" {
  description = "RDS instance class to provision."
  type        = string
  default     = "db.t3.micro"
}

variable "storage_size" {
  description = "Initial allocated storage in GiB."
  type        = number
  default     = 20

  validation {
    condition     = var.storage_size >= 20
    error_message = "The allocated storage must be at least 20 GiB to match the initial sizing from the ADR."
  }
}

variable "backup_retention_period" {
  description = "Number of days to keep automated backups. Defaults to 0 to keep costs minimal for sandbox use."
  type        = number
  default     = 0

  validation {
    condition     = var.backup_retention_period >= 0 && var.backup_retention_period <= 35
    error_message = "The backup retention period must be between 0 and 35 days."
  }
}

variable "deletion_protection" {
  description = "Whether the RDS instance should be protected from deletion."
  type        = bool
  default     = false
}
