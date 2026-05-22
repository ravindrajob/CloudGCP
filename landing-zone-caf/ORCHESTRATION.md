################################################################
# Titre: Documentation Orchestration CI/CD (GitHub Actions)
# Description : Guide sur le déploiement séquentiel de la LZ via WIF
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################

# Orchestration du Déploiement : Landing Zone GCP

Pour garantir l'intégrité de l'infrastructure, le déploiement de la Landing Zone ne doit jamais être manuel. Il suit un pipeline CI/CD industriel basé sur **GitHub Actions**, respectant le principe de **promotion par couches**.

## 🚀 Pipeline de Déploiement (Workflow)

L'orchestration est divisée en "Stages" dépendants les uns des autres. Si une couche échoue, le pipeline s'arrête immédiatement pour éviter toute incohérence (Blast Radius Control).

### Séquence de déploiement :
1.  **Stage: Foundations (Couche 00)** : Applique les *Organization Policies* (WIF Force, No Keys).
2.  **Stage: Hierarchy (Couche 01)** : Crée les dossiers et projets piliers.
3.  **Stage: Hub (Couche 02)** : Déploie le *Network Connectivity Center* (NCC) et le VPC Host.
4.  **Stage: Spokes (Couche 03)** : Raccorde les réseaux applicatifs au Hub.
5.  **Stage: Security (Couche 04)** : Verrouille l'ensemble via les *Hierarchical Firewalls*.

## 🛡️ Authentification : OIDC & WIF
Conformément à nos principes de sécurité, le pipeline n'utilise **aucune clé de Service Account (JSON)**. 
- GitHub Actions s'authentifie via le **Workload Identity Federation**.
- Un jeton d'accès de courte durée (60 min) est généré dynamiquement pour chaque job.

## ⚙️ Automatisation
Le fichier de workflow est disponible dans `.github/workflows/deploy-lz.yml`. 
Il utilise des environnements GitHub (`production`, `security-audit`) avec des approbations manuelles pour les étapes critiques (Couche 00 et 04).

---
*Orchestration SRE conçue pour la scalabilité par Ravindra JOB.*
