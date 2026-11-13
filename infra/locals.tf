locals {
  environment_name = lower(var.environment)
  resource_name    = "${var.project_name}-${local.environment_name}-postgres"
  application_databases = {
    os = {
      name    = "bunzina-os"
      service = "bunzina-os-postgres"
    }
    billing = {
      name    = "bunzina-billing"
      service = "bunzina-billing-postgres"
    }
  }
  common_tags = {
    Name        = local.resource_name
    Project     = var.project_name
    Environment = local.environment_name
    ManagedBy   = "terraform"
  }
}
