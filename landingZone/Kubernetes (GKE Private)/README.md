################################################################
# Titre: Kubernetes (GKE Private) - README
# Description : Isolation totale des nœuds Kubernetes
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.1 | RJ]
################################################################

# Kubernetes (Google Kubernetes Engine)

💡 **Rôle du composant :** 
L'orchestration des charges de travail applicatives via un cluster managé de haute disponibilité.

## Pourquoi ce choix technique ?
**GKE** est choisi pour son intégration native avec le réseau GCP (VPC-Native) et sa gestion avancée des mises à jour de sécurité.

## Hardening spécifique (vs Standard)
- **Private Nodes Only** : Contrairement au cluster par défaut qui expose ses nœuds sur Internet, nous imposons des **nœuds 100% privés**. La communication avec l'extérieur passe par le Cloud NAT du Hub.
- **Master Authorized Networks** : L'accès à l'API Kubernetes est verrouillé sur des IPs administratives précises.
- **Shielded Nodes** : Activation du démarrage sécurisé (Root-of-Trust matériel) pour empêcher le chargement de kernels malveillants sur les nœuds.
- **WIF for GKE** : Utilisation du Workload Identity pour que les pods s'authentifient auprès des API Google sans utiliser de fichiers de clés.

---
*Architecture CNCF sécurisée par Ravindra JOB.*
