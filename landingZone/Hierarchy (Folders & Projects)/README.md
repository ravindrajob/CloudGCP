# Couche 01 : Resource Hierarchy

Cette couche implémente la hiérarchie recommandée par le **Google Cloud Adoption Framework (CAF)**. L'objectif est de séparer les responsabilités et de limiter le rayon d'impact (*Blast Radius*) en cas d'incident.

## Architecture

- **Common Folder :** Héberge les services partagés par toute l'organisation (Réseau, Sécurité, Observabilité).
- **Workloads Folder :** Héberge les environnements applicatifs (Prod, Dev).

## Projets Piliers (CAF Ops & Security)
- **Host Project Hub :** Centralise la connectivité (VPC Host).
- **Logging & Monitoring :** Isoler la supervision permet de garantir l'intégrité des logs d'audit, même si un projet workload est compromis.
