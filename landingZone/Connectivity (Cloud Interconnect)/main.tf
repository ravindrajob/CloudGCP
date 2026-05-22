################################################################
# Titre: GCP Cloud Interconnect (Hybrid Connectivity)
# Description : Connexion privée dédiée (Dedicated Interconnect)
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################

# 1. Cloud Interconnect (CAF: Connectivity Foundation)
# Simulation d'un VLAN Attachment sur un circuit existant
resource "google_compute_interconnect_attachment" "on_prem" {
  name                     = "interconnect-lab-vlan"
  edge_availability_domain = "AVAILABILITY_DOMAIN_1"
  type                     = "DEDICATED"
  router                   = var.cloud_router_id
  project                  = var.project_id
  region                   = var.region
}

# 2. Cloud Router pour le routage dynamique BGP
resource "google_compute_router" "hybrid_router" {
  name    = "lab-gcp-hybrid-router"
  network = var.vpc_id
  project = var.project_id
  region  = var.region
  bgp {
    asn = 65001
  }
}
