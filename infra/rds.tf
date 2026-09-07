resource "aws_db_instance" "this" {
  identifier = local.resource_name

  engine         = "postgres"
  engine_version = "15"
  instance_class = var.instance_class

  allocated_storage = var.storage_size
  storage_type      = "gp2"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_password.result

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  parameter_group_name = aws_db_parameter_group.this.name

  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
  multi_az                = false

  auto_minor_version_upgrade = true
  apply_immediately          = true

  tags = merge(local.common_tags, {
    Name = local.resource_name
  })
}
