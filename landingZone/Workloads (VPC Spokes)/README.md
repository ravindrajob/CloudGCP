# Couche 03 : Network Spokes (Workloads)

Cette couche implémente les réseaux isolés destinés à héberger les applications. En suivant les recommandations de la **CNCF**, chaque environnement (Prod, Dev) possède son propre VPC pour garantir une isolation totale au niveau 3.

## Bonnes Pratiques Appliquées

### 🧩 Segmentation des Workloads (CAF)
- **Isolation par Projet :** Chaque VPC Spoke vit dans son propre projet GCP. Cela permet une gestion fine des quotas et des permissions IAM (Source : *CAF Isolation Pillar*).

### 🕸️ Connectivité par NCC (CNCF & Google)
- **Decoupled Connectivity :** Contrairement au Peering VPC traditionnel qui crée un maillage rigide, l'usage des **NCC Spokes** permet d'attacher et de détacher des réseaux de manière fluide et dynamique. (Source : *CNCF Cloud Native Network principles*).
- **Zéro Internet Direct :** Aucun de ces réseaux ne possède de passerelle Internet propre. Ils dépendent entièrement du Hub pour l'accès aux ressources externes, garantissant une inspection centralisée.
