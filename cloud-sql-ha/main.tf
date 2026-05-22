# ==============================================================================
# Terraform : Cloud SQL PostgreSQL HA (Private IP Only)
# Description : Base de données sécurisée pour le Lab de simulation
# ==============================================================================

resource "google_sql_database_instance" "postgres_ha" {
  name             = "lab-gcp-postgres-ha"
  database_version = "POSTGRES_15"
  region           = var.region

  # Protection contre la suppression accidentelle
  deletion_protection = true

  settings {
    tier              = "db-f1-micro" # Adapté pour un Lab
    availability_type = "REGIONAL"    # Haute Disponibilité (HA)

    backup_configuration {
      enabled    = true
      start_time = "02:00"
    }

    ip_configuration {
      ipv4_enabled                                  = false # Pas d'IP publique
      private_network                               = var.vpc_id
      enable_private_path_for_google_cloud_services = true
    }
  }
}

resource "google_sql_database" "n8n_db" {
  name     = "n8n"
  instance = google_sql_database_instance.postgres_ha.name
}

resource "google_sql_user" "n8n_user" {
  name     = "n8n_admin"
  instance = google_sql_database_instance.postgres_ha.name
  password = var.db_password
}
