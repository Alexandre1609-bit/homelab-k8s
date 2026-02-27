# Journal d'Avancement - Phase 2 : Configuration & Infrastructure as Code (Day-2)

## 1. Évolution Architecturale : Séparation des Responsabilités (SoC)

La transition vers le déploiement physique a nécessité une révision de la stratégie d'automatisation afin de respecter le principe de **Separation of Concerns (SoC)**.

Initialement, le plugin réseau (Flannel) était provisionné via Ansible. Cette approche monolithique a été abandonnée au profit d'une séparation stricte :

- **Ansible :** Dédié exclusivement au provisionnement de l'infrastructure de base (OS Hardening, Container Runtime, Binaires K8s). Le cluster est livré dans un état volontairement neutre (`NotReady`).
- **Terraform :** Responsable du "Configuration Management" du cluster. Il gère l'injection de la couche réseau (CNI), le stockage et les applications systèmes.

Cette modularité garantit une infrastructure plus testable, remplaçable et alignée sur les standards de production.

## 2. Initialisation de la Stack Terraform

En attente du matériel de connectivité (Switch réseau), l'arborescence Terraform a été initialisée et validée en "Dry-Run".

- **Configuration des Providers (`versions.tf` & `main.tf`) :** Mise en place des contraintes de versions strictes pour les providers `hashicorp/kubernetes` et `hashicorp/helm`. La frontière de communication avec le cluster est définie via la configuration du `kubeconfig`.
- **Sécurité de la Supply Chain (`.terraform.lock.hcl`) :** Lors de la phase d'initialisation (`terraform init`), le fichier de verrouillage des dépendances a été généré. Ce fichier garantit l'idempotence des futurs déploiements en figeant l'empreinte cryptographique exacte des providers utilisés. Cela empêche toute mise à jour silencieuse ou non désirée d'un plugin tiers qui pourrait compromettre l'infrastructure.

## 3. Architecture Réseau Cible : Implémentation de Cilium (eBPF)

Pour répondre aux exigences de sécurité (préparation CKS) et de performance d'un cluster Bare Metal moderne, le choix du CNI s'est porté sur **Cilium**, déployé via le provider Helm de Terraform.

**Justifications techniques du remplacement de `kube-proxy` / `iptables` :**

- **Limites d'iptables :** Historiquement utilisé par des solutions comme Flannel, `iptables` évalue les règles réseau séquentiellement, ce qui entraîne des goulets d'étranglement majeurs à grande échelle.
- **Le paradigme eBPF :** Cilium exploite eBPF (Extended Berkeley Packet Filter), permettant d'exécuter des programmes sécurisés directement dans le noyau Linux.
- **Bénéfices directs :**
  1. Routage des paquets extrêmement rapide.
  2. Filtrage réseau avancé au niveau de la couche 7 (HTTP,etc.).
  3. Observabilité en temps réel des flux réseau entre les Pods, indispensable pour l'audit et la détection d'intrusions (exigence CKS).

La prochaine étape consistera à appliquer (`terraform apply`) cette configuration dès la validation du provisionnement Ansible sur le matériel physique.
