################################################################
# Titre: Governance - SKU Restrictions (FinOps)
# Auteur: Ravindra JOB | v1.3
# Update: 23/05/2026
################################################################

# Interdiction stricte de lancer des instances GPUs (A100, TPU) ou très lourdes (M2, O2)
resource "google_project_organization_policy" "deny_expensive_machine_types" {
  project    = var.project_id
  constraint = "compute.restrictMachineTypes"

  list_policy {
    deny {
      values = [
        "a2-highgpu-*",
        "m2-*",
        "o2-*"
      ]
    }
  }
}

# Interdire le déploiement Cloud SQL sur de l'Enterprise Plus (trop cher pour du lab)
resource "google_project_organization_policy" "deny_sql_enterprise_plus" {
  project    = var.project_id
  constraint = "sql.restrictEditions"

  list_policy {
    deny {
      values = ["ENTERPRISE_PLUS"]
    }
  }
}
