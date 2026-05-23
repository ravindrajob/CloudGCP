################################################################
# Titre: FinOps (Billing Export & Quotas)
# Description : Export des données de facturation vers BigQuery et gestion des quotas
# Auteur: Ravindra JOB | v1.3
# Update: 22/05/2026
################################################################

# 1. Dataset BigQuery pour l'export de facturation (CAF: Financial Management)
resource "google_bigquery_dataset" "billing_dataset" {
  dataset_id                  = "lab_gcp_billing_export"
  friendly_name               = "Billing Export Dataset"
  description                 = "Stockage des données de facturation pour analyse FinOps"
  location                    = "EU"
  project                     = var.project_id
  delete_contents_on_destroy  = true
}

# 2. Budget et Alertes (Gouvernance FinOps)
resource "google_billing_budget" "budget" {
  billing_account = var.billing_account_id
  display_name    = "Lab-GCP-Monthly-Budget"

  budget_filter {
    projects = ["projects/${var.project_id}"]
  }

  amount {
    specified_amount {
      currency_code = "EUR"
      units         = "100"
    }
  }

  threshold_rules {
    threshold_percent = 0.5
  }
  threshold_rules {
    threshold_percent = 0.9
  }
  threshold_rules {
    threshold_percent = 1.0
  }
}
