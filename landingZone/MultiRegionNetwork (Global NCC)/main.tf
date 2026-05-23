################################################################
# Titre: Multi-Region Network (Global NCC Hub)
# Description : Backbone mondial via Network Connectivity Center
# Auteur: Ravindra JOB | v2.0
# Update: 23/05/2026
################################################################

# Le VPC Global natif de GCP (Netflix/Google style)
resource "google_compute_network" "global_vpc" {
  name                    = "vpc-global-hub-lab"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL" # Routage dynamique sur toute la planète
}

# Subnet Région 1 (europe-west1)
resource "google_compute_subnetwork" "sub_eu_west1" {
  name          = "snet-eu-west1-prod"
  ip_cidr_range = "10.200.0.0/24"
  region        = "europe-west1"
  network       = google_compute_network.global_vpc.id
}

# Subnet Région 2 (europe-west9 - DRP)
resource "google_compute_subnetwork" "sub_eu_west9" {
  name          = "snet-eu-west9-prod"
  ip_cidr_range = "10.201.0.0/24"
  region        = "europe-west9"
  network       = google_compute_network.global_vpc.id
}

# Hub NCC pour centraliser l'interconnexion (Interconnect, VPN, Routers)
resource "google_network_connectivity_hub" "global_hub" {
  name        = "ncc-global-hub-lab"
  description = "Hub de routage global Cloud/On-Prem"
  project     = var.project_id
}
