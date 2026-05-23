################################################################
# Titre: FinOps - Auto-Shutdown (Non-Prod)
# Auteur: Ravindra JOB | v1.3
# Update: 23/05/2026
################################################################

# Cloud Function pour stopper les instances GCE et GKE Non-Prod
resource "google_cloudfunctions_function" "finops_shutdown" {
  name        = "func-finops-shutdown-lab"
  description = "Arrêt automatique des ressources taggées Non-Prod"
  runtime     = "python310"
  project     = var.project_id
  region      = var.region

  available_memory_mb   = 256
  source_archive_bucket = var.source_bucket_name
  source_archive_object = "shutdown_code.zip"
  entry_point           = "stop_instances"
  
  environment_variables = {
    TARGET_LABEL = "non-prod"
  }
}

# Cloud Scheduler pour déclencher l'extinction à 20h00
resource "google_cloud_scheduler_job" "nightly_shutdown" {
  name             = "job-nightly-shutdown"
  description      = "Déclenche la Cloud Function d'extinction"
  schedule         = "0 20 * * *"
  time_zone        = "Europe/Paris"
  project          = var.project_id
  region           = var.region

  pubsub_target {
    topic_name = google_pubsub_topic.shutdown_topic.id
    data       = base64encode("shutdown")
  }
}

resource "google_pubsub_topic" "shutdown_topic" {
  name    = "topic-finops-shutdown"
  project = var.project_id
}
