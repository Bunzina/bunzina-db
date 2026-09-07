output "db_endpoint" {
  description = "DNS endpoint of the PostgreSQL instance."
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "Port used by PostgreSQL."
  value       = aws_db_instance.this.port
}

output "db_secret_arn" {
  description = "ARN of the secret containing the PostgreSQL credentials."
  value       = aws_secretsmanager_secret.db_credentials.arn
}
