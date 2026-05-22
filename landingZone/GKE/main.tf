################################################################
# Titre: GKE Private Cluster (Hardened)
# Description : Cluster Kubernetes managé sans IP publique pour les nœuds
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################

resource "google_container_cluster" "primary" {
  name     = "lab-gke-cluster"
  location = var.region
  project  = var.project_id

  # CAF Reference: Separation of concerns (Control Plane vs Nodes)
  networking_mode = "VPC_NATIVE"
  network         = var.network_id
  subnetwork      = var.subnetwork_id

  # Sécurité : Désactivation de l'accès public au Control Plane
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false # Endpoint public restreint par master_authorized_networks
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.admin_cidr
      display_name = "Admin-Access"
    }
  }

  # CNCF Compliance: Shielded Nodes
  enable_shielded_nodes = true

  # On utilise un node pool séparé
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "lab-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  project    = var.project_id
  node_count = 2

  node_config {
    machine_type = "e2-medium"
    
    # IAM Least Privilege
    service_account = var.service_account_email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]

    # Security Hardening
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }
}
