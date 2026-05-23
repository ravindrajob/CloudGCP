################################################################
# Titre: Secret Orchestration (GKE Secret Manager)
# Description : Intégration Native via GCP Secret Manager
# Auteur: Ravindra JOB | v2.0
# Update: 23/05/2026
################################################################

# Avec GCP, l'utilisation de Workload Identity permet aux pods
# d'interroger directement Secret Manager sans CSI driver lourd.

resource "kubernetes_service_account" "app_sa" {
  metadata {
    name      = "app-sa"
    namespace = "application-tier"
    annotations = {
      "iam.gke.io/gcp-service-account" = var.gcp_service_account_email
    }
  }
}

# IAM Binding: Le SA Kubernetes est autorisé à agir comme SA GCP
resource "google_service_account_iam_binding" "workload_identity_binding" {
  service_account_id = var.gcp_service_account_id
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[application-tier/app-sa]"
  ]
}
