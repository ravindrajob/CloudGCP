################################################################
# Titre: Network Spokes & NCC Attachments
# Description : Réseaux applicatifs (Prod/Dev) isolés et rattachés au Hub
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
# ==============================================================================
# Terraform : Network Spokes & NCC Attachments
# Description : Réseaux applicatifs (Prod/Dev) isolés et rattachés au Hub
# Référence : CNCF - Decoupled & Micro-segmented Architectures
# Référence : CAF Isolation - Workload Segmentation
# ==============================================================================

# 1. VPC Spoke (Environnement Production)
resource "google_compute_network" "spoke_prod_vpc" {
  name                    = "lab-gcp-prod-vpc"
  auto_create_subnetworks = false
  project                 = var.prod_project_id
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "prod_subnet" {
  name          = "lab-gcp-prod-subnet"
  ip_cidr_range = "10.1.0.0/24"
  region        = var.region
  network       = google_compute_network.spoke_prod_vpc.id
  project       = var.prod_project_id
}

# 2. Attachement au NCC (Network Connectivity Center)
# Remplace le VPC Peering : routage dynamique et centralisé.
resource "google_network_connectivity_spoke" "prod_ncc_spoke" {
  name     = "lab-gcp-prod-spoke"
  hub      = var.ncc_hub_id
  location = "global"
  project  = var.hub_project_id # Géré dans le Hub pour la cohérence

  linked_vpc_network {
    uri = google_compute_network.spoke_prod_vpc.self_link
  }
}

# 3. Interdiction de sortie Internet locale (CAF: Security)
# On ne crée PAS de Cloud NAT ici. Toutes les routes par défaut (0.0.0.0/0)
# doivent être propagées depuis le Hub via le NCC.
