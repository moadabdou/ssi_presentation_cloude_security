# Présentation Sécurité Cloud — Architecture Cyberpunk

## 🕒 Speaker 1 : Introduction & Configuration de l'Environnement

---

### Slide 1 : HACKING THE CLOUD : Pourquoi la sécurité est vitale
> **Design Vibe :** Fond noir absolu. Une grille vert fluo "Matrix" s'estompe vers le bas. Le titre est en police monospace glitchée (cyan électrique et magenta).

**Points Clés :**
* Le Cloud est le nouveau champ de bataille.
* Plus de 70% des fuites de données proviennent de **mauvaises configurations**, pas de piratages complexes.
* Un port ouvert ou un bucket public suffit pour tout perdre.

**Notes pour l'orateur (Speaker 1) :**
"Bonjour à tous. Bienvenue dans notre deep-dive sur la sécurité Cloud. Aujourd'hui, nous n'allons pas parler d'attaques complexes de la NSA, mais de la réalité brute : les failles viennent souvent d'une simple ligne de code mal écrite. Une seule erreur de configuration, un seul port laissé grand ouvert, et c'est la clé de voûte de votre infrastructure qui s'effondre."

---

### Slide 2 : L'Arsenal : Nos Outils de Simulation
> **Design Vibe :** Icônes au style ligne-néon (hologrammes) flottant au-dessus d'un terminal. Couleurs dominantes : bleu électrique et vert hacker.

**Points Clés :**
* **LocalStack :** Le clone local d'AWS (zéro coût, zéro fuite externe).
* **Terraform :** Infrastructure as Code (IaC) pour des déploiements reproductibles.
* **Trivy :** Le scanner de sécurité open-source intraitable.

**Notes pour l'orateur (Speaker 1) :**
"Pour cette démonstration, on opère en environnement clos. LocalStack nous permet d'émuler AWS directement sur nos machines sans risque. L'infrastructure est codée avec Terraform pour avoir une trace de chaque ressource. Et Trivy sera notre 'scanner infrarouge' pour détecter les failles avant même le déploiement."

---

### Slide 3 : L'Infrastructure Cible
> **Design Vibe :** Schéma holographique bleu néon d'un serveur (EC2) relié à un coffre-fort de données (Bucket S3).

**Points Clés :**
* **Objectif :** Un environnement simple et fonctionnel.
* **Bucket S3 :** Stockage cloud pour nos sauvegardes critiques.
* **Serveur EC2 :** Machine virtuelle avec un accès SSH pour l'administration à distance.

**Notes pour l'orateur (Speaker 1) :**
"Voici ce que nous essayons de construire aujourd'hui : une infrastructure cible très classique. Nous avons besoin d'un Bucket S3 pour héberger nos sauvegardes internes critiques, et d'un serveur EC2 avec un accès SSH pour que nos administrateurs puissent travailler à distance. Simple, non ? Voyons comment cela peut déraper."

---

## 🕒 Speaker 2 : L'Architecture Vulnérable & Le Test Trivy

---

### Slide 4 : La Configuration "Débutant"
> **Design Vibe :** Un bloc de code Terraform brillant en vert terminal old-school sur fond noir. Les blocs critiques pulsent en rouge alerte.

**Extrait de Code (Terminal) :**
```terraform
# Déploiement inexpérimenté
resource "aws_s3_bucket_public_access_block" "vulnerable_block" {
  block_public_acls       = false # "Ça marche comme ça..."
}

ingress {
  from_port   = 22
  cidr_blocks = ["0.0.0.0/0"] # L'accès universel
}
```

**Notes pour l'orateur (Speaker 2) :**
"Voici à quoi ressemble le code d'une personne inexpérimentée qui veut juste 'que ça marche'. On désactive les blocages de sécurité sur le bucket S3 pour ne pas être embêté par les droits, et on ouvre le port SSH à l'univers entier (`0.0.0.0/0`) pour être sûr de pouvoir s'y connecter de n'importe où."

---

### Slide 5 : L'Épreuve du Feu : Trivy
> **Design Vibe :** Fenêtre de terminal au style HUD cyberpunk. Un radar de balayage holographique révèle les vulnérabilités en rouge.

**Points Clés :**
* **Trivy :** Le scanner de sécurité open-source pour l'IaC.
* Analyse du code Terraform.
* **Bilan : 9 Misconfigurations** trouvées !

**Notes pour l'orateur (Speaker 2) :**
"Pour évaluer ce code, nous allons utiliser Trivy, un scanner de sécurité open-source. On lance la commande d'analyse sur notre fichier Terraform. Le résultat est immédiat et sans appel : au lieu d'une infrastructure prête pour la production, Trivy lève une alerte rouge et pointe exactement 9 erreurs de configuration critiques."

---

## 🕒 Speaker 3 : Comprendre les Risques (Sans Jargon)

---

### Slide 6 : Les Portes Grandes Ouvertes
> **Design Vibe :** L'image d'un bâtiment d'entreprise virtuel dont la porte d'entrée est grande ouverte, avec des données qui s'envolent (flux lumineux magenta).

**Points Clés (L'Impact des Erreurs) :**
* **Données Publiques (S3) :** Sauvegardes accessibles à tous sur Internet.
* **Accès SSH (0.0.0.0/0) :** La porte de l'entreprise ouverte à l'univers.
* **Pas de Chiffrement :** Données volées = Données lues sans effort.

**Notes pour l'orateur (Speaker 3) :**
"Mais concrètement, que signifient ces erreurs ? Simplifions. Laisser le bucket S3 public, c'est comme laisser nos dossiers confidentiels sur la place publique. Ouvrir le port SSH à tout l'univers, c'est laisser la porte d'entrée de l'entreprise grande ouverte 24h/24, invitant n'importe quel hacker ou ransomware. Pire encore, sans chiffrement, si nos données sont volées, elles sont directement lisibles."

---

### Slide 7 : Pas de Caméras, Pas de Bouton "Undo"
> **Design Vibe :** Une caméra de sécurité brisée en style néon rouge, et une icône de retour en arrière rayée.

**Points Clés :**
* **Absence de Logs (Traçabilité) :** Pas de caméras de sécurité pour tracer les hackers.
* **Absence de Versioning :** Aucun bouton "annuler" en cas de ransomware.

**Notes pour l'orateur (Speaker 3) :**
"Les autres erreurs remontées par Trivy concernent ce qui se passe pendant ou après l'attaque. En n'activant pas les logs d'accès, c'est comme n'avoir aucune caméra de sécurité pour comprendre comment les hackers sont entrés. Sans versioning sur nos sauvegardes, si un virus chiffre nos données, nous n'avons aucun bouton 'annuler' pour les récupérer. C'est une catastrophe assurée."

---

## 🕒 Speaker 4 : L'Architecture Fortifiée & Conclusion

---

### Slide 8 : Les Correctifs Blindés
> **Design Vibe :** Extrait de code Terraform cyan étincelant avec un bouclier d'énergie holographique superposé par-dessus.

**Points Clés :**
* **Blocage Total & Chiffrement (KMS)**
* **Filtrage IP strict :** SSH uniquement depuis l'IP de notre VPN.
* **Versioning & Logging :** Sécurité rétroactive et audits.

**Notes pour l'orateur (Speaker 4) :**
"Pour colmater ces brèches, nous passons sur notre version durcie. Les accès publics au bucket sont bloqués de force et le chiffrement KMS est activé. L'accès SSH est maintenant strictement restreint à la seule adresse IP de notre VPN d'entreprise. Pour finir, les logs et le versioning sont configurés en bonne et due forme."

---

### Slide 9 : La Validation Trivy (0 Erreurs)
> **Design Vibe :** Un terminal affichant un scan réussi en vert fluo étincelant avec un gros message "SUCCESS / CLEAN".

**Extrait de Terminal :**
```text
versions/main_v2.tf (terraform)
================================
Tests: 9 (SUCCESSES: 9, FAILURES: 0)

✅ All security checks passed!
```

**Notes pour l'orateur (Speaker 4) :**
"La preuve de l'efficacité est dans le terminal. En repassant Trivy sur cette nouvelle version, le scanner indique que les 9 erreurs de configuration ont totalement disparu. Notre infrastructure est validée et prête au combat."

---

### Slide 10 : Conclusion
> **Design Vibe :** Plan large sur l'horizon d'une Cyber-métropole étoilée. Titre fort en lettres capitales néon magenta. 

**Points Clés :**
* **Un grand pouvoir implique...**
* L'IaC déploie vite, les scanners déploient bien.
* *In Code We Trust, But We Verify.*

**Notes pour l'orateur (Speaker 4) :**
"Pour conclure, l'Infrastructure as Code nous permet de déployer extrêmement vite, mais elle permet tristement de déployer des failles tout aussi vite. En scannant l'infrastructure avec Trivy avant le déploiement et en respectant de simples bonnes pratiques, on bloque 90% des attaques du cloud. Merci à tous pour votre attention, nous sommes à votre disposition pour vos questions !"
