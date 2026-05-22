################################################################
# Titre: CloudGCP - README
# Description : Lab de simulation Google Cloud Platform Hardened
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v2.2 | RJ]
################################################################

# Google Cloud Platform : Landing Zone Hardened

Ce dépôt centralise les briques d'infrastructure (IaC) nécessaires au déploiement d'une **Landing Zone** souveraine et sécurisée sur Google Cloud. L'architecture suit une approche standardisée, conforme aux piliers du **Cloud Adoption Framework (CAF)** et aux recommandations de la **CNCF**.

---

### 🧱 Architecture du Lab

L'infrastructure est découpée en modules indépendants, permettant une promotion granulaire des ressources.

| Module | Fonctionnalité | Hardening Spécifique |
| :--- | :--- | :--- |
| **`Governance`** | Policies & IAM | WIF Only, interdiction des SA Keys, Domain Restriction. |
| **`Connectivity`** | Network Hub | NCC (Network Connectivity Center), Cloud NAT centralisé. |
| **`Connectivity`** | Hybrid Link | Cloud Interconnect (Dedicated), routage BGP, Private Service Connect. |
| **`Firewall`** | Network Security | Politiques hiérarchiques, "Deny by Default" Ingress/Egress. |
| **`Kubernetes`** | Orchestration | GKE Private Nodes, Shielded Instances, Master Authorized Networks. |
| **`EgressProxy`** | L7 Inspection | Secure Web Proxy (Envoy), filtrage FQDN Whitelisting. |
| **`LoadBalancer`** | App Exposition | Global LB7, certificats Google, WAF Cloud Armor. |
| **`AI-Security`** | AI Agent Gateway | Proxy sémantique (A2A) pour le contrôle des interactions LLM. |

---

### 🛡️ Principes de Sécurité (Security by Design)

- **Identité Zéro Trust :** Utilisation systématique du Workload Identity Federation (WIF). Zéro secret statique dans le code.
- **Isolation Réseau :** Aucun composant (nœuds K8s, Bases de données) n'est exposé sur l'Internet public. L'administration s'effectue via IAP (Identity-Aware Proxy).
- **Gouvernance Immuable :** Les Organization Policies verrouillent l'usage des ressources au niveau racine (No Public IP, No Public Buckets).

### ⚙️ Déploiement & Orchestration

L'orchestration est pilotée par un pipeline GitOps (GitHub Actions) situé dans `.github/workflows/`. Le déploiement s'effectue par couches successives pour garantir l'intégrité de l'état (State Integrity).

---
*Note : Ce dépôt est un environnement de simulation (Lab). Les configurations sont isolées et utilisent exclusivement le domaine `ravindra-job.com`.*
