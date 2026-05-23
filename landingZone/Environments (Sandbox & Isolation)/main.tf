################################################################
# Titre: Environments (Sandbox & Isolation)
# Auteur: Ravindra JOB | v1.3
# Update: 23/05/2026
################################################################

# Projet GCP isolé physiquement (Pas de Shared VPC)
resource "google_project" "sandbox_project" {
  name            = "Lab Sandbox Environment"
  project_id      = "lab-sandbox-isolated-${var.random_suffix}"
  folder_id       = var.sandbox_folder_id
  billing_account = var.billing_account_id
}

# Budget hyper-agressif
resource "google_billing_budget" "sandbox_budget" {
  billing_account = var.billing_account_id
  display_name    = "budget-sandbox-strict"

  budget_filter {
    projects = ["projects/${google_project.sandbox_project.project_id}"]
  }

  amount {
    specified_amount {
      currency_code = "EUR"
      units         = "50"
    }
  }

  # Déclenche un kill switch via Pub/Sub Cloud Function si 100%
  threshold_rules {
    threshold_percent = 1.0
  }
  
  all_updates_rule {
    pubsub_topic = var.kill_switch_topic_id
  }
}
