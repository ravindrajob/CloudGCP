################################################################
# Titre: DNS (Cloud DNS Private)
# Description : Maillage Zéro Trust et entrées de simulation Lab
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.2 | RJ]
################################################################

# 1. Zone DNS Privée (CAF: Split-Horizon DNS)
resource "google_dns_managed_zone" "private_zone" {
  name        = "lab-gcp-private-zone"
  dns_name    = "ravindra-job.com."
  description = "Zone DNS privée pour le Lab de simulation"
  project     = var.project_id

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = var.vpc_id # Liaison physique au VPC
    }
  }
}

# 2. Enregistrements DNS de démonstration (Simulation Lab)
# Illustre l'adressage interne pour une architecture micro-segmentée

resource "google_dns_record_set" "api_gateway" {
  name         = "api.ravindra-job.com."
  managed_zone = google_dns_managed_zone.private_zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["10.100.0.10"] # IP fictive du LB interne
  project      = var.project_id
}

resource "google_dns_record_set" "database_private" {
  name         = "db-prod.ravindra-job.com."
  managed_zone = google_dns_managed_zone.private_zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["10.1.0.50"] # IP fictive de Cloud SQL Private
  project      = var.project_id
}

resource "google_dns_record_set" "vertex_ai_endpoint" {
  name         = "ai-inference.ravindra-job.com."
  managed_zone = google_dns_managed_zone.private_zone.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["private.googleapis.com."] # DNS Peering vers Google Services
  project      = var.project_id
}
