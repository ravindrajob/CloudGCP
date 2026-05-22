################################################################
# Titre: AI (Vertex AI)
# Description : Plateforme IA unifiée avec Private Service Connect
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.1 | RJ]
################################################################

# 1. Dataset Vertex AI (Simulation d'entraînement)
resource "google_vertex_ai_dataset" "lab_dataset" {
  display_name = "lab-gcp-vertex-dataset"
  metadata_schema_uri = "gs://google-cloud-aiplatform/schema/dataset/metadata/image_1.0.0.yaml"
  region       = var.region
  project      = var.project_id
}

# 2. Endpoint Vertex AI (Servicing)
# Sécurité : Exposition interne via Private Service Connect (PSC)
resource "google_vertex_ai_endpoint" "ai_endpoint" {
  name         = "lab-ai-endpoint"
  display_name = "lab-ai-endpoint-internal"
  location     = var.region
  project      = var.project_id
  
  # Hardening : Restreindre l'accès au réseau interne VPC uniquement
}

# 3. Private Service Connect (PSC) pour Vertex AI
# CAF Reference: Zero Trust API Access
resource "google_compute_address" "ai_psc_ip" {
  name         = "ai-psc-internal-ip"
  subnetwork   = var.subnet_id
  address_type = "INTERNAL"
  region       = var.region
  project      = var.project_id
}

resource "google_compute_forwarding_rule" "ai_psc_rule" {
  name                  = "ai-psc-forwarding-rule"
  region                = var.region
  project               = var.project_id
  target                = "all-apis" # Endpoints API Google
  network               = var.vpc_id
  ip_address            = google_compute_address.ai_psc_ip.id
  load_balancing_scheme = ""
}

# 4. Exposition via Load Balancer (LB7)
# On utilise le Forwarding Rule pour router le trafic du LB7 vers l'IP interne du PSC
