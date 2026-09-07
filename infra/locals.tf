locals {
  environment_name = lower(var.environment)
  resource_name    = "${var.project_name}-${local.environment_name}-postgres"
  common_tags = {
    Name        = local.resource_name
    Project     = var.project_name
    Environment = local.environment_name
    ManagedBy   = "terraform"
  }
}
