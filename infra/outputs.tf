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

output "application_postgres_services" {
  description = "Kubernetes Services used by bunzina-os and bunzina-billing."
  value = {
    for key, database in local.application_databases : key => {
      service   = kubernetes_service_v1.application_postgres[key].metadata[0].name
      database  = database.name
      namespace = kubernetes_namespace_v1.this.metadata[0].name
    }
  }
}

output "application_postgres_secret_names" {
  description = "Kubernetes Secrets containing credentials for each application PostgreSQL instance."
  value = {
    for key, secret in kubernetes_secret_v1.application_postgres : key => secret.metadata[0].name
  }
}
