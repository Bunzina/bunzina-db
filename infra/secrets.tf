resource "aws_secretsmanager_secret" "db_credentials" {
  name = "${var.project_name}/${local.environment_name}/postgres"

  description             = "Credentials for the ${var.environment} PostgreSQL instance."
  recovery_window_in_days = 0

  tags = merge(local.common_tags, {
    Name = "${local.resource_name}-secret"
  })
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    engine   = "postgres"
    host     = aws_db_instance.this.address
    port     = aws_db_instance.this.port
    dbname   = var.db_name
  })
}

resource "random_password" "db_password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}:<>?"
}
