################################################################
# Titre: Network Connectivity Center (NCC) & Hub VPC
# Description : Hub central de transit pour la topologie Hub-and-Spoke
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
# ==============================================================================
# Terraform : Network Connectivity Center (NCC) & Hub VPC
# Description : Hub central de transit pour la topologie Hub-and-Spoke
# Référence : Google Modern Networking - NCC Hub
# Référence : CAF Security - Centralized Egress & Inspection
# ==============================================================================

# 1. Le Hub NCC (Le cerveau du routage)
resource "google_network_connectivity_hub" "main_hub" {
  name        = "lab-gcp-ncc-hub"
  description = "Hub de transit central pour toute l'organisation ravindra-job.com"
  project     = var.hub_project_id
}

# 2. Le VPC Hub (Le réseau de transit)
resource "google_compute_network" "hub_vpc" {
  name                    = "lab-gcp-hub-vpc"
  auto_create_subnetworks = false
  project                 = var.hub_project_id
  # Routing mode Global pour le NCC
  routing_mode            = "GLOBAL"
}

# Subnet de transit (Services partagés comme Bastion, VPN)
resource "google_compute_subnetwork" "transit_subnet" {
  name          = "lab-gcp-transit-subnet"
  ip_cidr_range = "10.100.0.0/24"
  region        = var.region
  network       = google_compute_network.hub_vpc.id
  project       = var.hub_project_id
}

# 3. Sortie Internet Sécurisée (CAF: Infrastructure Foundation)
# Aucun Spoke n'aura d'accès direct, tout passe par le NAT du Hub.
resource "google_compute_router" "hub_router" {
  name    = "lab-gcp-hub-router"
  region  = var.region
  network = google_compute_network.hub_vpc.id
  project = var.hub_project_id
}

resource "google_compute_router_nat" "hub_nat" {
  name                               = "lab-gcp-hub-nat"
  router                             = google_compute_router.hub_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project                            = var.hub_project_id
}
