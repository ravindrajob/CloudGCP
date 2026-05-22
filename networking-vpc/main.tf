# ==============================================================================
# Terraform : Networking VPC & Private Service Access
# Description : Base réseau pour le Lab de simulation (ravindra-job.com)
# ==============================================================================

resource "google_compute_network" "vpc_network" {
  name                    = "lab-gcp-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "app_subnet" {
  name          = "lab-gcp-app-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Adresse IP réservée pour le peering avec les services Google (Cloud SQL)
resource "google_compute_global_address" "private_ip_address" {
  name          = "lab-gcp-private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

# Connexion de service privée (VPC Peering vers Google Services)
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# Serverless VPC Access Connector (Pour Cloud Run -> Cloud SQL Private IP)
resource "google_vpc_access_connector" "connector" {
  name          = "lab-vpc-connector"
  region        = var.region
  ip_cidr_range = "10.8.0.0/28"
  network       = google_compute_network.vpc_network.name
}
