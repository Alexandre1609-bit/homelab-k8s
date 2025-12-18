# Préparation Matérielle (Hardware)

## Objectif du Projet
Ce projet de HomeLab a pour ambition de simuler un cluster de serveurs tel qu'on pourrait le trouver en production chez des acteurs du Cloud comme OVH, Google ou Amazon.

L'objectif principal est de monter en compétence sur la chaîne complète du DevOps et de l'Infrastructure as Code (IaC), en manipulant des outils standards comme **Ansible** et **Kubernetes** (K8s).

## Le Choix du Matériel
J'ai investi dans un cluster composé de **3 unités Lenovo ThinkCentre M720q** d'occasion.

**Pourquoi ce choix ?**
* **Compacité & Silence :** Ces machines "Tiny" s'intègrent parfaitement dans un environnement domestique sans nuisance sonore.
* **Robustesse :** Gamme professionnelle conçue pour durer.
* **Rapport Qualité/Prix :** Une solution économique pour simuler un vrai cluster physique (Bare Metal) par rapport à la location de serveurs dédiés.

## Réception et Validation (18/12/2025)
J'ai reçu la première machine du cluster aujourd'hui. Avant de pouvoir lancer l'installation automatisée (qui nécessitera les 3 nœuds), j'ai effectué une validation matérielle :

1.  **Vérification BIOS :** Confirmation de l'absence de mot de passe superviseur (BIOS déverrouillé).
2.  **Virtualisation :** Activation des options **VT-x** et **VT-d** dans le CPU Setup.
3.  **Audit des specs :** Validation de la présence du processeur i5-9400T, des 8 Go de RAM et du stockage NVMe 256 Go.

## Le Choix de l'OS : Ubuntu Server 24.04 LTS
Pour le système d'exploitation, j'ai pivoté vers **Ubuntu Server 24.04 LTS**.

**Justification technique & Stratégique :**
* **Alignement CKA/CKS :** Les examens officiels de la Linux Foundation (Certified Kubernetes Administrator) se basent sur Ubuntu. Utiliser cet OS me permet de m'entraîner dans les conditions exactes de l'examen.
* **Support Matériel :** Le noyau Linux d'Ubuntu offre une compatibilité native optimale avec le matériel des Lenovo Tiny.
* **Standard K8s :** C'est la distribution de référence pour les déploiements Kubernetes Bare Metal.
* **Maîtrise :** L'installation se fera en mode "Minimized". Je n'utiliserai pas les paquets "Snap" pré-packagés pour Kubernetes, mais j'installerai les binaires officiels pour garder un contrôle total et "propre" de la stack.