################################################################
# Titre: Self-Service - Custom FinOps Schedule (GCP)
# Description: Paramétrage du cron Cloud Scheduler
# Auteur: Ravindra JOB | v2.0
################################################################

resource "google_cloud_scheduler_job" "custom_shutdown" {
  count            = var.environment != "Prod" ? 1 : 0
  name             = "job-shutdown-${var.app_name}"
  description      = "Extinction pour ${var.app_name}"
  schedule         = var.shutdown_schedule
  time_zone        = "Europe/Paris"
  project          = google_project.app_project.project_id
  region           = var.region

  pubsub_target {
    topic_name = data.google_pubsub_topic.central_finops.id
    data       = base64encode("{\"target_project\":\"${google_project.app_project.project_id}\"}")
  }
}
