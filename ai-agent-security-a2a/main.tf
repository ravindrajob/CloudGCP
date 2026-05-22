################################################################
# Titre: AI Agent Security Gateway (A2A)
# Description : Architecture de sécurisation des agents IA via un proxy Cloud Run
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 15/10/2025 [v1.0 | RJ]
################################################################

# 1. Service Account dédié à l'Agent IA (Principle of Least Privilege)
resource "google_service_account" "ai_agent_sa" {
  account_id   = "ai-secure-agent-sa"
  display_name = "AI Secure Agent Service Account"
  project      = var.project_id
}

# 2. Secret Manager pour les clés d'API (Éviter le hardcoding)
resource "google_secret_manager_secret" "llm_api_key" {
  secret_id = "llm-api-key-secure"
  project   = var.project_id
  replication {
    automatic = true
  }
}

# 3. Cloud Run Proxy (A2A Gateway)
# Ce service intercepte les prompts et applique des filtres de sécurité (Prowler, Guardrails)
resource "google_cloud_run_v2_service" "ai_proxy" {
  name     = "ai-security-proxy-a2a"
  location = var.region
  project  = var.project_id

  template {
    containers {
      image = "ghcr.io/ravindrajob/ai-security-proxy:latest" # Image simulée pour le Lab
      
      env {
        name = "API_KEY_SECRET_ID"
        value = google_secret_manager_secret.llm_api_key.id
      }
      
      env {
        name = "SECURITY_MODE"
        value = "paranoid"
      }
      
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }
    
    service_account = google_service_account.ai_agent_sa.email
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

# 4. IAM : Autoriser l'Agent à appeler Vertex AI uniquement
resource "google_project_iam_member" "ai_user_role" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.ai_agent_sa.email}"
}

# 5. IAM : Accès au Secret Manager
resource "google_secret_manager_secret_iam_member" "secret_access" {
  secret_id = google_secret_manager_secret.llm_api_key.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.ai_agent_sa.email}"
}
