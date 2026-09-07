resource "aws_db_parameter_group" "this" {
  name   = local.resource_name
  family = "postgres15"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }

  parameter {
    name  = "log_statement"
    value = "all"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "0"
  }

  tags = merge(local.common_tags, {
    Name = "${local.resource_name}-parameter-group"
  })
}
