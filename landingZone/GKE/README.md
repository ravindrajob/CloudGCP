################################################################
# Titre: GKE Hardened - Documentation
# Description : Guide de déploiement Kubernetes sur GCP (CAF/CNCF)
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################

# GKE Private Cluster (Hardened)

💡 **Philosophie : Security by Isolation**
L'infrastructure déploie un cluster Kubernetes managé (GKE) suivant les standards de la **CNCF**. Les nœuds du cluster n'ont aucune adresse IP publique, limitant ainsi drastiquement la surface d'attaque.

## Bonnes Pratiques Appliquées (CAF & CNCF)

- **VPC Native & Private Nodes :** Les communications inter-pods et le management s'effectuent via le réseau interne uniquement.
- **Shielded GKE Nodes :** Utilisation d'instances durcies avec démarrage sécurisé et surveillance de l'intégrité (Secure Boot).
- **Control Plane Isolation :** L'accès à l'API Kubernetes est restreint à des plages IP administratives spécifiques via les `master_authorized_networks`.
- **Least Privilege :** Le pool de nœuds utilise un Service Account IAM dédié, limitant les droits du cluster sur le projet GCP.

## Déploiement de l'Application Demo
Une fois le cluster provisionné, nous pouvons déployer l'application de démonstration présente dans le dossier `app-demo-manifests/` :
```bash
gcloud container clusters get-credentials lab-gke-cluster --region europe-west1
kubectl apply -f app-demo-manifests/
```
