output "postgres_service_name" {
  description = "Kubernetes Service name used by the application to reach PostgreSQL."
  value       = kubernetes_service_v1.postgres.metadata[0].name
}

output "postgres_namespace" {
  description = "Kubernetes namespace containing PostgreSQL."
  value       = kubernetes_namespace_v1.this.metadata[0].name
}

output "postgres_secret_name" {
  description = "Kubernetes Secret containing the PostgreSQL credentials."
  value       = "postgres"
}


output "postgres_port" {
  description = "Port used by the PostgreSQL Kubernetes Service."
  value       = 5432
}
