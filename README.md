# CloudGCP - Lab de Simulation Google Cloud Platform

💡 **Philosophie & Partage :** 
Ce dépôt est un laboratoire de démonstration pour les architectures **Google Cloud Platform**. Il reflète mon approche méticuleuse et sécurisée de l'infrastructure "Cloud Native". 

Les configurations Terraform ici présentes sont des simulations conçues pour partager des bonnes pratiques sur le domaine **ravindra-job.com**. (OPSEC oblige, mon infrastructure réelle est isolée).

## 🏗️ Architecture du Lab

L'infrastructure est modulaire et suit une logique de séparation des responsabilités (**1 dossier = 1 composant**) :

1.  **`networking-vpc/`** : Fondation réseau (VPC, Subnets) avec mise en place du *Private Service Access* et du *Serverless VPC Connector*.
2.  **`cloud-sql-ha/`** : Instance PostgreSQL en Haute Disponibilité (HA), sans aucune IP publique, accessible uniquement via le réseau interne.
3.  **`n8n-cloudrun-secure/`** : Orchestration N8N sur Cloud Run, connectée à la base SQL privée via le connecteur VPC.
4.  **`lb7-global-external/`** : Exposition HTTPS sécurisée avec certificats managés et protection WAF via **Cloud Armor**.
5.  **`vertex-ai-platform/`** : Provisionnement des ressources pour l'Intelligence Artificielle (Endpoints, Datasets) avec gestion fine de l'IAM.

## 🔒 Sécurité par Design
- **Zéro IP Publique** pour les bases de données.
- **Accès Serverless sécurisé** via VPC Peering.
- **WAF Cloud Armor** pour bloquer les injections SQL et les menaces L7.
- **Principe du moindre privilège** appliqué aux Service Accounts IA.

---
*Ce dépôt est maintenu par Ravindra, ingénieur passionné par l'automatisation et la cybersécurité.*
