resource "kubernetes_namespace_v1" "this" {
  metadata {
    name = var.kubernetes_namespace
  }
}

resource "kubernetes_secret_v1" "postgres" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  type = "Opaque"

  data = {
    POSTGRES_USER     = var.db_username
    POSTGRES_PASSWORD = var.db_password
    POSTGRES_DB       = var.db_name
  }
}

resource "kubernetes_persistent_volume_claim_v1" "postgres" {
  metadata {
    name      = "postgres-data"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = var.storage_class_name

    resources {
      requests = {
        storage = "${var.storage_size}Gi"
      }
    }
  }

  depends_on = [kubernetes_storage_class_v1.gp3]
}

resource "kubernetes_deployment_v1" "postgres" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
    labels = {
      app = "postgres"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "postgres"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }

      spec {
        container {
          name              = "postgres"
          image             = var.postgres_image
          image_pull_policy = "IfNotPresent"

          port {
            name           = "postgres"
            container_port = 5432
          }

          env_from {
            secret_ref {
              name = "postgres"
            }
          }

          env {
            name  = "PGDATA"
            value = "/var/lib/postgresql/data/pgdata"
          }

          volume_mount {
            name       = "postgres-data"
            mount_path = "/var/lib/postgresql/data"
          }

        }

        volume {
          name = "postgres-data"

          persistent_volume_claim {
            claim_name = "postgres-data"
          }
        }

      }
    }
  }

}

resource "kubernetes_service_v1" "postgres" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  spec {
    selector = {
      app = "postgres"
    }

    port {
      name        = "postgres"
      port        = 5432
      target_port = 5432
    }

    type = "ClusterIP"
  }
}