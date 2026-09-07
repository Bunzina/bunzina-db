resource "aws_security_group" "this" {
  name        = "${local.resource_name}-sg"
  description = "Allow PostgreSQL access from the application layer."
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = length(var.allowed_cidr_blocks) > 0 ? [1] : []

    content {
      description = "PostgreSQL access from allowed CIDR blocks"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    }
  }

  dynamic "ingress" {
    for_each = length(var.allowed_security_group_ids) > 0 ? [1] : []

    content {
      description     = "PostgreSQL access from allowed security groups"
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      security_groups = var.allowed_security_group_ids
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.resource_name}-sg"
  })
}
