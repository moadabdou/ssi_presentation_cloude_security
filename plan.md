# Cloud Security Presentation Plan (12 Minutes)

**Team Size:** 4 Presenters  
**Total Target Time:** ~12 minutes (approx. 3 minutes per speaker)

---

## 🕒 Speaker 1: Introduction & Environment Setup (3 minutes)
**Goal:** Hook the audience, explain the "Why" of cloud security, and introduce the demo environment.

* **Introduction (1 min):** Briefly introduce the team and the importance of cloud security. Explain that misconfigurations (like open ports and public buckets) are the leading cause of cloud data breaches.
* **Environment Setup (1 min):** Explain the tools used for the demo.
  * **LocalStack:** Used to simulate an AWS cloud environment locally without incurring costs or connection issues.
  * **Terraform (IaC):** Used to provision the infrastructure, allowing for reproducible and trackable configurations.
* **Target Infrastructure (1 min):** Describe what we are trying to build. We need a simple setup: an S3 bucket to store important backups and a virtual server (EC2) with SSH access for remote management.

---

## 🕒 Speaker 2: Case 1 - The Vulnerable Architecture & Testing (3 minutes)
**Goal:** Show what an inexperienced Terraform configuration looks like and use a security scanner to find flaws.

* **The "Inexperienced" Configuration (1.5 mins):** Walk through `versions/main_v1.tf`. Show how someone new to the cloud might just try to "make it work" without considering security (e.g., using default S3 settings, allowing SSH from anywhere).
* **Testing with Trivy (1.5 mins):** 
  * Introduce **Trivy**, an open-source security scanner for infrastructure as code.
  * Execute the scan (`outputs/trivy.sh`) on the inexperienced code.
  * Point out that Trivy found exactly **9 misconfigurations** in this simple setup.

---

## 🕒 Speaker 3: Understanding the Security Risks (3 minutes)
**Goal:** Explain the impact of the 9 misconfigurations found, using simple, non-technical terms.

* **Breaking Down the Findings (3 mins):** Group the 9 misconfigurations and explain their real-world impact without deep technical jargon:
  * **Publicly Accessible Data (S3):** Missing access blocks means anyone on the internet could potentially find and steal the organization's sensitive backups.
  * **No Encryption:** If data is intercepted or physical drives are accessed, the data is in plain text for anyone to read.
  * **Wide Open Doors (Security Groups):** Leaving SSH open to the whole world (`0.0.0.0/0`) is like leaving the front door of a corporate building wide open, inviting hackers to launch ransomware or guessing attacks.
  * **Lack of Logging/Versioning:** If a breach or mistake happens, there are no cameras (logs) to see what happened and no undo button (versioning) to restore lost data.

---

## 🕒 Speaker 4: The Hardened Architecture & Conclusion (3 minutes)
**Goal:** Present the solutions, demonstrate the secure code, and wrap up the presentation with a final clean scan.

* **Proposing the Fixes (1.5 mins):** Display `versions/main_v2.tf` and highlight the hardened best practices:
  * Blocking all public access and adding server-side encryption.
  * Restricting SSH access to a specific, trusted corporate IP range.
  * Enabling versioning and access logging.
* **Validating the Fix (1 min):** Run the Trivy scanner again against the new hardened version. Show the audience that the 9 misconfigurations have disappeared, resulting in a clean bill of health.
* **Conclusion (0.5 mins):** 
  * Summarize the core message: IaC makes it easy to deploy, but also easy to deploy vulnerabilities. Security scanners and best practices are essential.
  * Open the floor for any Q&A.