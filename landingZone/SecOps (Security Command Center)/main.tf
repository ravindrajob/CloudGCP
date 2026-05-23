################################################################
# Titre: SecOps (Security Command Center)
# Description : Configuration du SOC Cloud natif et détection des menaces
# Auteur: Ravindra JOB | v1.3
# Update: 22/05/2026
################################################################

# 1. Activation de SCC (Security Command Center) au niveau organisation
# Note: La gestion se fait souvent au niveau org, ici simulé au niveau projet pour le Lab.
resource "google_scc_source" "custom_source" {
  display_name = "Lab Custom Security Source"
  organization = var.org_id
  description  = "Source de détection pour les audits de sécurité du Lab"
}

# 2. Notification Config (Alerte vers Pub/Sub pour remédiation automatisée)
resource "google_pubsub_topic" "scc_notifications" {
  name    = "scc-findings-topic"
  project = var.project_id
}

resource "google_scc_notification_config" "scc_config" {
  config_id    = "lab-scc-notif"
  organization = var.org_id
  description  = "Streaming des alertes de sécurité vers le SOC central"
  pubsub_topic = google_pubsub_topic.scc_notifications.id

  streaming_config {
    filter = "state = \"ACTIVE\""
  }
}
