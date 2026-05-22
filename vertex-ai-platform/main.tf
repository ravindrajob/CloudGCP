# ==============================================================================
# Terraform : Vertex AI Platform Foundation
# Description : Infrastructure IA Cloud Native (Simulation Lab)
# ==============================================================================

# Dataset Vertex AI pour l'entraînement (Simulation)
resource "google_vertex_ai_dataset" "lab_dataset" {
  display_name = "lab-gcp-ai-dataset"
  metadata_schema_uri = "gs://google-cloud-aiplatform/schema/dataset/metadata/image_1.0.0.yaml"
  region       = var.region
}

# Endpoint Vertex AI pour servir des modèles LLM
resource "google_vertex_ai_endpoint" "lab_endpoint" {
  name         = "lab-gcp-ai-endpoint"
  display_name = "lab-gcp-ai-servicing-endpoint"
  location     = var.region
  
  description  = "Endpoint de simulation pour l'inférence via Gemini 3.5"
}

# IAM : Service Account dédié aux agents IA
resource "google_service_account" "ai_agent_sa" {
  account_id   = "lab-gcp-ai-agent-sa"
  display_name = "Agent IA Lab Simulation"
}

resource "google_project_iam_member" "ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.ai_agent_sa.email}"
}
