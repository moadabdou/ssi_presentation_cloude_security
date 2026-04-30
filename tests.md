# Speaker 4: Live Demos & Tests Cheat Sheet

This file contains the exact commands you need to copy-paste during the live presentation to demonstrate the vulnerabilities, the live fixes, and the data recovery.

## 1. The Vulnerability Test (Before the Fix)
*Run these commands while `main_v1.tf` (the vulnerable version) is deployed.*

**A. Show the Trivy Errors (The Scanner):**
```bash
trivy config .
```
*(Explain: "Look, we have exactly 9 critical/high misconfigurations right out of the gate.")*

**B. Show the Open Port Policy (The Hacker's view):**
```bash
# Since LocalStack only simulates the AWS API and doesn't actually run a real VM on your laptop, 
# nmap won't work physically. Instead, show how a hacker easily queries open cloud configurations!
awslocal ec2 describe-security-groups --group-names dev-ssh-access | grep -B 2 -A 2 "0.0.0.0/0"
```
*(Explain: "Hackers run automated scripts against AWS APIs all the time. By querying our configuration, they instantly see that port 22 is mapped to 0.0.0.0/0, which means they can start their brute-force attacks from anywhere.")*

---

## 2. The Live Fix (DevSecOps Feedback Loop)
*Demonstrate how quickly a developer gets security feedback.*

**A. The Live Edit:**
1. Open `main.tf` in front of the class.
2. Go to the `aws_security_group` section.
3. Change `cidr_blocks = ["0.0.0.0/0"]` to `cidr_blocks = ["123.45.67.89/32"]`.
4. Save the file.

**B. Redo the Test:**
```bash
trivy config .
```
*(Explain: "Notice how the errors dropped from 9 to 8 immediately. We caught the open port vulnerability before it ever reached the cloud.")*

---

## 3. The Hardened Deployment & Disaster Recovery
*Now, assume we deployed the fully secure `versions/main_v2.tf` which has S3 Versioning enabled. We will simulate a ransomware attack/accidental deletion and recover the data.*

**A. Deploy the Secure Infrastructure:**
```bash
# Copy the secure version over main.tf and apply
cp versions/main_v2.tf main.tf
tflocal apply -auto-approve
```

**B. Create & Upload a Critical File:**
```bash
echo "VERY SECRET BACKUP DATA: DO NOT LOSE" > secret.txt
awslocal s3 cp secret.txt s3://company-internal-backups-secured-2026/
```

**C. Simulate the Attack (Delete the file):**
```bash
# A rogue admin or hacker deletes the file
awslocal s3 rm s3://company-internal-backups-secured-2026/secret.txt

# Prove it's gone
awslocal s3 ls s3://company-internal-backups-secured-2026/
```

**D. The Recovery (Because we enabled Versioning):**
```bash
# 1. Look at the hidden versions to find the "DeleteMarker"
awslocal s3api list-object-versions --bucket company-internal-backups-secured-2026 --prefix secret.txt

# Look for the "DeleteMarkers" array in the output and copy the "VersionId". 
# 2. Delete the DeleteMarker to restore the file
# Run this command, replacing <COPIED_VERSION_ID> with the actual ID:
awslocal s3api delete-object --bucket company-internal-backups-secured-2026 --key secret.txt --version-id <COPIED_VERSION_ID>

# 3. Prove the file is back!
awslocal s3 ls s3://company-internal-backups-secured-2026/
awslocal s3 cp s3://company-internal-backups-secured-2026/secret.txt -
```
*(Explain: "Because we followed the 'Versioning' best practice caught by Trivy, deleting a file just adds a 'Delete Marker'. By removing that marker, our critical data is instantly restored.")*
