# Couche 04 : Security Policies (Zéro Trust)

Cette couche implémente le verrouillage réseau global de l'organisation. En utilisant les **Hierarchical Firewall Policies**, nous appliquons une sécurité uniforme sur tous les projets et VPCs de la Landing Zone, sans avoir besoin de répliquer des règles manuellement dans chaque réseau.

## Bonnes Pratiques Appliquées

### 🛡️ Zéro Trust Network Architecture (CNCF)
- **Deny by Default :** Nous avons implémenté une règle de priorité maximale qui rejette tout trafic entrant par défaut. C'est le socle du modèle Zéro Trust : aucune confiance n'est accordée aux flux, même internes, sans autorisation explicite. (Source : *CNCF ZTNA whitepaper*).

### 🏛️ Gouvernance Centralisée (CAF)
- **Hierarchical Firewalls :** La politique est rattachée au niveau du Dossier (Folder). Cela garantit qu'aucune "Shadow IT" (projet créé par un utilisateur sans passer par la sécurité) ne puisse bypasser les règles de l'entreprise. (Source : *CAF Security Governance Pillar*).
- **Service-to-Service :** Seuls les flux provenant du Hub de supervision (SRE) sont autorisés à interroger les instances.
