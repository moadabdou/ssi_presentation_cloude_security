## plan.md

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
* **Scenario Overview (1 min):** Introduce the two cases that will be demonstrated: 
  * *Case 1:* A poorly configured environment.
  * *Case 2:* A hardened, secure architecture following best practices.

---

## 🕒 Speaker 2: Case 1 - The Vulnerable Architecture (3 minutes)
**Goal:** Show what bad practices look like in code and how they can be exploited.

* **Code Walkthrough (1.5 mins):** Display `versions/main_v1.tf`. Point out the critical flaws:
  * **Public S3 Bucket:** No public access block (`block_public_acls = false`).
  * **Open Security Group:** SSH (port 22) is open to the world (`0.0.0.0/0`), creating a "Front Door" breach opportunity for ransomware or brute-force attacks.
* **Deployment & Walkthrough (1.5 mins):** 
  * Briefly show the output of the infrastructure creation (`outputs/apply_case1.sh`).
  * **The Vulnerability:** Discuss the risk of data exfiltration and how the lack of proper access blocks exposes the internal backup data to the public.

---

## 🕒 Speaker 3: Vulnerability Identification (3 minutes)
**Goal:** Teach the audience how to detect these flaws automatically using security tools before deploying to production.

* **The Shift-Left Approach (1 min):** Explain the importance of catching vulnerabilities in the Infrastructure-as-Code (IaC) phase rather than after deployment.
* **Trivy Demonstration (2 mins):**
  * Introduce **Trivy**, an open-source security scanner.
  * Show the command `trivy config .` being run against the insecure code.
  * Walk through the scan results (`outputs/trivy.sh`). Point out exactly how Trivy highlights the S3 public access and the overly permissive SSH port.

---

## 🕒 Speaker 4: Case 2 - The Hardened Architecture & Conclusion (3 minutes)
**Goal:** Present the solutions, demonstrate the secure code, and wrap up the presentation.

* **Hardened Code Walkthrough (2 mins):** Display `versions/main_v2.tf` and highlight the *Six Best Practices* implemented:
  1. **Enforce Public Access Block:** Overriding accidental bucket policy changes.
  2. **Server-Side Encryption:** Utilizing AWS KMS to ensure physical data security.
  3. **Restrictive Firewall:** Changing the Security Group to only allow SSH from a specific corporate VPN IP (`123.45.67.89/32`).
  4. **Enforce HTTPS / Deny Anonymous HTTP:** Using bucket policies to deny unauthenticated traffic.
  5. **Bucket Versioning:** Protecting against accidental deletion and overwrites.
  6. **Server Access Logging:** Creating an audit trail for forensic analysis.
* **Secure Deployment & Conclusion (1 min):** 
  * Mention the secure deployment output (`outputs/apply_case2.sh`) and the clean Trivy scan on the second version (`outputs/trivy_case2.sh`).
  * Summarize the presentation's core message: IaC misconfigurations are dangerous, but easily avoidable using tools like Trivy and adhering to cloud best practices.
  * Open the floor for any Q&A.

## outputs/apply_case1.sh

```text

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # aws_s3_bucket.sensitive_data[0m will be created
[0m  [32m+[0m[0m resource "aws_s3_bucket" "sensitive_data" {
      [32m+[0m[0m acceleration_status         = (known after apply)
      [32m+[0m[0m acl                         = (known after apply)
      [32m+[0m[0m arn                         = (known after apply)
      [32m+[0m[0m bucket                      = "company-internal-backups-2026"
      [32m+[0m[0m bucket_domain_name          = (known after apply)
      [32m+[0m[0m bucket_namespace            = (known after apply)
      [32m+[0m[0m bucket_prefix               = (known after apply)
      [32m+[0m[0m bucket_region               = (known after apply)
      [32m+[0m[0m bucket_regional_domain_name = (known after apply)
      [32m+[0m[0m force_destroy               = false
      [32m+[0m[0m hosted_zone_id              = (known after apply)
      [32m+[0m[0m id                          = (known after apply)
      [32m+[0m[0m object_lock_enabled         = (known after apply)
      [32m+[0m[0m policy                      = (known after apply)
      [32m+[0m[0m region                      = "us-east-1"
      [32m+[0m[0m request_payer               = (known after apply)
      [32m+[0m[0m tags_all                    = (known after apply)
      [32m+[0m[0m website_domain              = (known after apply)
      [32m+[0m[0m website_endpoint            = (known after apply)

      [32m+[0m[0m cors_rule (known after apply)

      [32m+[0m[0m grant (known after apply)

      [32m+[0m[0m lifecycle_rule (known after apply)

      [32m+[0m[0m logging (known after apply)

      [32m+[0m[0m object_lock_configuration (known after apply)

      [32m+[0m[0m replication_configuration (known after apply)

      [32m+[0m[0m server_side_encryption_configuration (known after apply)

      [32m+[0m[0m versioning (known after apply)

      [32m+[0m[0m website (known after apply)
    }

[1m  # aws_s3_bucket_public_access_block.vulnerable_block[0m will be created
[0m  [32m+[0m[0m resource "aws_s3_bucket_public_access_block" "vulnerable_block" {
      [32m+[0m[0m block_public_acls       = false
      [32m+[0m[0m block_public_policy     = false
      [32m+[0m[0m bucket                  = (known after apply)
      [32m+[0m[0m id                      = (known after apply)
      [32m+[0m[0m ignore_public_acls      = false
      [32m+[0m[0m region                  = "us-east-1"
      [32m+[0m[0m restrict_public_buckets = false
    }

[1m  # aws_security_group.insecure_sg[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "insecure_sg" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Allows SSH from anywhere"
      [32m+[0m[0m egress                 = (known after apply)
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ingress                = [
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "0.0.0.0/0",
                ]
              [32m+[0m[0m from_port        = 22
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
                [90m# (1 unchanged attribute hidden)[0m[0m
            },
        ]
      [32m+[0m[0m name                   = "dev-ssh-access"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m region                 = "us-east-1"
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags_all               = (known after apply)
      [32m+[0m[0m vpc_id                 = (known after apply)
    }

[1mPlan:[0m [0m3 to add, 0 to change, 0 to destroy.
[0m[1maws_security_group.insecure_sg: Creating...[0m[0m
[0m[1maws_s3_bucket.sensitive_data: Creating...[0m[0m
[0m[1maws_security_group.insecure_sg: Creation complete after 0s [id=sg-b6d999e07309540b7][0m
[0m[1maws_s3_bucket.sensitive_data: Creation complete after 0s [id=company-internal-backups-2026][0m
[0m[1maws_s3_bucket_public_access_block.vulnerable_block: Creating...[0m[0m
[0m[1maws_s3_bucket_public_access_block.vulnerable_block: Creation complete after 0s [id=company-internal-backups-2026][0m
[0m[1m[32m
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.[0m

```

## outputs/apply_case2.sh

```text
[0m[1maws_security_group.secure_sg: Refreshing state... [id=sg-25dc32f940d4d29ed][0m
[0m[1maws_s3_bucket.secure_data: Refreshing state... [id=company-internal-backups-secured-2026][0m
[0m[1maws_s3_bucket_public_access_block.hardened_block: Refreshing state... [id=company-internal-backups-secured-2026][0m
[0m[1maws_s3_bucket_server_side_encryption_configuration.secure_encryption: Refreshing state... [id=company-internal-backups-secured-2026][0m

[1m[36mNote:[0m[1m Objects have changed outside of Terraform
[0m
Terraform detected the following changes made outside of Terraform since the
last "terraform apply" which may have affected this plan:

[1m  # aws_s3_bucket.secure_data[0m has been deleted
[0m  [31m-[0m[0m resource "aws_s3_bucket" "secure_data" {
      [31m-[0m[0m id                          = "company-internal-backups-secured-2026" [90m-> null[0m[0m
        [90m# (15 unchanged attributes hidden)[0m[0m

        [90m# (3 unchanged blocks hidden)[0m[0m
    }


Unless you have made equivalent changes to your configuration, or ignored the
relevant attributes using ignore_changes, the following plan may include
actions to undo or respond to these changes.
[90m
─────────────────────────────────────────────────────────────────────────────[0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # aws_s3_bucket.secure_data[0m will be created
[0m  [32m+[0m[0m resource "aws_s3_bucket" "secure_data" {
      [32m+[0m[0m acceleration_status         = (known after apply)
      [32m+[0m[0m acl                         = (known after apply)
      [32m+[0m[0m arn                         = (known after apply)
      [32m+[0m[0m bucket                      = "company-internal-backups-secured-2026"
      [32m+[0m[0m bucket_domain_name          = (known after apply)
      [32m+[0m[0m bucket_namespace            = (known after apply)
      [32m+[0m[0m bucket_prefix               = (known after apply)
      [32m+[0m[0m bucket_region               = (known after apply)
      [32m+[0m[0m bucket_regional_domain_name = (known after apply)
      [32m+[0m[0m force_destroy               = false
      [32m+[0m[0m hosted_zone_id              = (known after apply)
      [32m+[0m[0m id                          = (known after apply)
      [32m+[0m[0m object_lock_enabled         = (known after apply)
      [32m+[0m[0m policy                      = (known after apply)
      [32m+[0m[0m region                      = "us-east-1"
      [32m+[0m[0m request_payer               = (known after apply)
      [32m+[0m[0m tags_all                    = (known after apply)
      [32m+[0m[0m website_domain              = (known after apply)
      [32m+[0m[0m website_endpoint            = (known after apply)

      [32m+[0m[0m cors_rule (known after apply)

      [32m+[0m[0m grant (known after apply)

      [32m+[0m[0m lifecycle_rule (known after apply)

      [32m+[0m[0m logging (known after apply)

      [32m+[0m[0m object_lock_configuration (known after apply)

      [32m+[0m[0m replication_configuration (known after apply)

      [32m+[0m[0m server_side_encryption_configuration (known after apply)

      [32m+[0m[0m versioning (known after apply)

      [32m+[0m[0m website (known after apply)
    }

[1m  # aws_s3_bucket_public_access_block.hardened_block[0m will be created
[0m  [32m+[0m[0m resource "aws_s3_bucket_public_access_block" "hardened_block" {
      [32m+[0m[0m block_public_acls       = true
      [32m+[0m[0m block_public_policy     = true
      [32m+[0m[0m bucket                  = (known after apply)
      [32m+[0m[0m id                      = (known after apply)
      [32m+[0m[0m ignore_public_acls      = true
      [32m+[0m[0m region                  = "us-east-1"
      [32m+[0m[0m restrict_public_buckets = true
    }

[1m  # aws_s3_bucket_server_side_encryption_configuration.secure_encryption[0m will be created
[0m  [32m+[0m[0m resource "aws_s3_bucket_server_side_encryption_configuration" "secure_encryption" {
      [32m+[0m[0m bucket = (known after apply)
      [32m+[0m[0m id     = (known after apply)
      [32m+[0m[0m region = "us-east-1"

      [32m+[0m[0m rule {
          [32m+[0m[0m blocked_encryption_types = (known after apply)
          [32m+[0m[0m bucket_key_enabled       = (known after apply)

          [32m+[0m[0m apply_server_side_encryption_by_default {
              [32m+[0m[0m kms_master_key_id = (known after apply)
              [32m+[0m[0m sse_algorithm     = "AES256"
            }
        }
    }

[1m  # aws_security_group.secure_sg[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "secure_sg" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Allows SSH ONLY from corporate VPN"
      [32m+[0m[0m egress                 = (known after apply)
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ingress                = [
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "123.45.67.89/32",
                ]
              [32m+[0m[0m from_port        = 22
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
                [90m# (1 unchanged attribute hidden)[0m[0m
            },
        ]
      [32m+[0m[0m name                   = "secure-ssh-access"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m region                 = "us-east-1"
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags_all               = (known after apply)
      [32m+[0m[0m vpc_id                 = (known after apply)
    }

[1mPlan:[0m [0m4 to add, 0 to change, 0 to destroy.
[0m[1maws_security_group.secure_sg: Creating...[0m[0m
[0m[1maws_s3_bucket.secure_data: Creating...[0m[0m
[0m[1maws_security_group.secure_sg: Creation complete after 1s [id=sg-40b1c73901aae88da][0m
[0m[1maws_s3_bucket.secure_data: Creation complete after 1s [id=company-internal-backups-secured-2026][0m
[0m[1maws_s3_bucket_public_access_block.hardened_block: Creating...[0m[0m
[0m[1maws_s3_bucket_server_side_encryption_configuration.secure_encryption: Creating...[0m[0m
[0m[1maws_s3_bucket_public_access_block.hardened_block: Creation complete after 0s [id=company-internal-backups-secured-2026][0m
[0m[1maws_s3_bucket_server_side_encryption_configuration.secure_encryption: Creation complete after 0s [id=company-internal-backups-secured-2026][0m
[0m[1m[32m
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.[0m

```

## outputs/init_case1.sh

```text
[0m[1mInitializing the backend...[0m
[0m[1mInitializing provider plugins...[0m
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v6.42.0...
- Installed hashicorp/aws v6.42.0 (signed by HashiCorp)
Terraform has created a lock file [1m.terraform.lock.hcl[0m to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.[0m

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m

```

## outputs/trivy.sh.txt

```text

Report Summary

┌──────────────────────┬───────────┬───────────────────┐
│        Target        │   Type    │ Misconfigurations │
├──────────────────────┼───────────┼───────────────────┤
│ .                    │ terraform │         0         │
├──────────────────────┼───────────┼───────────────────┤
│ main.tf              │ terraform │         0         │
├──────────────────────┼───────────┼───────────────────┤
│ versions             │ terraform │         0         │
├──────────────────────┼───────────┼───────────────────┤
│ versions /main_v1.tf │ terraform │         9         │
├──────────────────────┼───────────┼───────────────────┤
│ versions /main_v2.tf │ terraform │         0         │
└──────────────────────┴───────────┴───────────────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)


versions /main_v1.tf (terraform)
================================
Tests: 9 (SUCCESSES: 0, FAILURES: 9)
Failures: 9 (UNKNOWN: 0, LOW: 2, MEDIUM: 1, HIGH: 6, CRITICAL: 0)

AWS-0086 (HIGH): Public access block does not block public ACLs
══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
S3 buckets should block public ACLs on buckets and any objects they contain. By blocking, PUTs with fail if the object has any public ACL a.


See https://avd.aquasec.com/misconfig/aws-0086
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 versions /main_v1.tf:15
   via versions /main_v1.tf:12-19 (aws_s3_bucket_public_access_block.vulnerable_block)
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  12   resource "aws_s3_bucket_public_access_block" "vulnerable_block" {
  13     bucket = aws_s3_bucket.sensitive_data.id
  14   
  15 [   block_public_acls       = false
  16     block_public_policy     = false
  17     ignore_public_acls      = false
  18     restrict_public_buckets = false
  19   }
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


AWS-0087 (HIGH): Public access block does not block public policies
══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
S3 bucket policy should have block public policy to prevent users from putting a policy that enable public access.


See https://avd.aquasec.com/misconfig/aws-0087
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 versions /main_v1.tf:16
   via versions /main_v1.tf:12-19 (aws_s3_bucket_public_access_block.vulnerable_block)
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  12   resource "aws_s3_bucket_public_access_block" "vulnerable_block" {
  13     bucket = aws_s3_bucket.sensitive_data.id
  14   
  15     block_public_acls       = false
  16 [   block_public_policy     = false
  17     ignore_public_acls      = false
  18     restrict_public_buckets = false
  19   }
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


AWS-0089 (LOW): Bucket has logging disabled
══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Ensures S3 bucket logging is enabled for S3 buckets

See https://avd.aquasec.com/misconfig/aws-0089
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 versions /main_v1.tf:7-9
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   7 ┌ resource "aws_s3_bucket" "sensitive_data" {
   8 │   bucket = "company-internal-backups-2026"
   9 └ }
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


AWS-0090 (MEDIUM): Bucket does not have versioning enabled
══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Versioning in Amazon S3 is a means of keeping multiple variants of an object in the same bucket.

You can use the S3 Versioning feature to preserve, retrieve, and restore every version of every object stored in your buckets.

With versioning you can recover more easily from both unintended user actions and application failures.

When you enable versioning, also keep in mind the potential costs of storing noncurrent versions of objects. To help manage those costs, consider setting up an S3 Lifecycle configuration.


See https://avd.aquasec.com/misconfig/aws-0090
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 versions /main_v1.tf:7-9
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   7 ┌ resource "aws_s3_bucket" "sensitive_data" {
   8 │   bucket = "company-internal-backups-2026"
   9 └ }
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


AWS-0091 (HIGH): Public access block does not ignore public ACLs
══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
S3 buckets should ignore public ACLs on buckets and any objects they contain. By ignoring rather than blocking, PUT calls with public ACLs will still be applied but the ACL will be ignored.


See https://avd.aquasec.com/misconfig/aws-0091
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 versions /main_v1.tf:17
   via versions /main_v1.tf:12-19 (aws_s3_bucket_public_access_block.vulnerable_block)
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  12   resource "aws_s3_bucket_public_access_block" "vulnerable_block" {
  13     bucket = aws_s3_bucket.sensitive_data.id
  14   
  15     block_public_acls       = false
  16     block_public_policy     = false
  17 [   ignore_public_acls      = false
  18     restrict_public_buckets = false
  19   }
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


AWS-0093 (HIGH): Public access block does not restrict public buckets
══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
S3 buckets should restrict public policies for the bucket. By enabling, the restrict_public_buckets, only the bucket owner and AWS Services can access if it has a public policy.


See https://avd.aquasec.com/misconfig/aws-0093
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 versions /main_v1.tf:18
   via versions /main_v1.tf:12-19 (aws_s3_bucket_public_access_block.vulnerable_block)
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  12   resource "aws_s3_bucket_public_access_block" "vulnerable_block" {
  13     bucket = aws_s3_bucket.sensitive_data.id
  14   
  15     block_public_acls       = false
  16     block_public_policy     = false
  17     ignore_public_acls      = false
  18 [   restrict_public_buckets = false
  19   }
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


AWS-0107 (HIGH): Security group rule allows unrestricted ingress from any IP address.
══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Security groups provide stateful filtering of ingress and egress network traffic to AWS
resources. It is recommended that no security group allows unrestricted ingress access to
remote server administration ports, such as SSH to port 22 and RDP to port 3389.


See https://avd.aquasec.com/misconfig/aws-0107
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 versions /main_v1.tf:30
   via versions /main_v1.tf:26-31 (ingress)
    via versions /main_v1.tf:22-32 (aws_security_group.insecure_sg)
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  22   resource "aws_security_group" "insecure_sg" {
  23     name        = "dev-ssh-access"
  24     description = "Allows SSH from anywhere"
  25   
  26     ingress {
  27       from_port   = 22
  28       to_port     = 22
  29       protocol    = "tcp"
  30 [     cidr_blocks = ["0.0.0.0/0"] 
  ..   
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


AWS-0124 (LOW): Security group rule does not have a description.
══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Security group rules should include a description for auditing purposes.

Simplifies auditing, debugging, and managing security groups.


See https://avd.aquasec.com/misconfig/aws-0124
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 versions /main_v1.tf:26-31
   via versions /main_v1.tf:22-32 (aws_security_group.insecure_sg)
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  22   resource "aws_security_group" "insecure_sg" {
  23     name        = "dev-ssh-access"
  24     description = "Allows SSH from anywhere"
  25   
  26 ┌   ingress {
  27 │     from_port   = 22
  28 │     to_port     = 22
  29 │     protocol    = "tcp"
  30 └     cidr_blocks = ["0.0.0.0/0"] 
  ..   
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


AWS-0132 (HIGH): Bucket does not encrypt data with a customer managed key.
══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
Encryption using AWS keys provides protection for your S3 buckets. To gain greater control over encryption, such as key rotation, access policies, and auditability, use customer managed keys (CMKs) with SSE-KMS.
Note that SSE-KMS is not supported for S3 server access logging destination buckets; in such cases, use SSE-S3 instead.


See https://avd.aquasec.com/misconfig/aws-0132
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 versions /main_v1.tf:7-9
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   7 ┌ resource "aws_s3_bucket" "sensitive_data" {
   8 │   bucket = "company-internal-backups-2026"
   9 └ }
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────



```

## versions /main_v1.tf.txt

```text
# main.tf
provider "aws" {
  region = "us-east-1"
}

# RISK 1: S3 Bucket with Public Access (Data Leakage)
resource "aws_s3_bucket" "sensitive_data" {
  bucket = "company-internal-backups-2026"
}

# Explicitly disabling public access blocks to simulate a leak
resource "aws_s3_bucket_public_access_block" "vulnerable_block" {
  bucket = aws_s3_bucket.sensitive_data.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# RISK 2: Security Group with Wide-Open SSH (Ransomware/Brute Force)
resource "aws_security_group" "insecure_sg" {
  name        = "dev-ssh-access"
  description = "Allows SSH from anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}
```

## versions /main_v2.tf.txt

```text
# main.tf - HARDENED VERSION
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true
  endpoints {
    s3  = "http://localhost:4566"
    ec2 = "http://localhost:4566"
  }
}

# --- STORAGE SECURITY ---
resource "aws_s3_bucket" "secure_data" {
  bucket = "company-internal-backups-secured-2026"
}

# BEST PRACTICE 1: Enforce Public Access Block
# This is a "safety net" that overrides any accidental bucket policy changes.
resource "aws_s3_bucket_public_access_block" "hardened_block" {
  bucket = aws_s3_bucket.secure_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# BEST PRACTICE 2: Server-Side Encryption
# Even if someone steals the physical hard drive from an AWS data center, 
# the data is unreadable without the key.
resource "aws_kms_key" "s3_key" {
  description             = "KMS key to encrypt S3 objects"
  enable_key_rotation     = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "secure_encryption" {
  bucket = aws_s3_bucket.secure_data.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# BEST PRACTICE 4: Enforce HTTPS / Deny Anonymous HTTP
# This explicit policy forces a 403 Forbidden for unencrypted/unauthenticated HTTP requests
resource "aws_s3_bucket_policy" "enforce_https" {
  bucket = aws_s3_bucket.secure_data.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyAll"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource  = [
          aws_s3_bucket.secure_data.arn,
          "${aws_s3_bucket.secure_data.arn}/*"
        ]
      }
    ]
  })
}

# --- NETWORK SECURITY ---
# BEST PRACTICE 3: Restrictive Firewall (Security Group)
resource "aws_security_group" "secure_sg" {
  name        = "secure-ssh-access"
  description = "Allows SSH ONLY from corporate VPN"

  ingress {
    description = "SSH access strictly from corporate VPN"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Replace with your actual IP address. Never use 0.0.0.0/0
    cidr_blocks = ["123.45.67.89/32"] 
  }
}
# BEST PRACTICE 5: Bucket Versioning
# Prevent accidental deletion or overwrite by retaining all object versions.
resource "aws_s3_bucket_versioning" "secure_versioning" {
  bucket = aws_s3_bucket.secure_data.id
  versioning_configuration {
    status = "Enabled"
  }
}

# BEST PRACTICE 6: Server Access Logging
# Audit trail for all access requests made to the secure bucket.
resource "aws_s3_bucket" "audit_logs" {
  bucket = "company-internal-backups-audit-logs-2026"
}

# Audit Logs Bucket also needs basic security to pass Trivy
resource "aws_s3_bucket_public_access_block" "audit_logs_block" {
  bucket                  = aws_s3_bucket.audit_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# trivy:ignore:AVD-AWS-0132
resource "aws_s3_bucket_server_side_encryption_configuration" "audit_logs_enc" {
  bucket = aws_s3_bucket.audit_logs.id
  rule {
    # Logging buckets must use AES256, not KMS
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "audit_logs_versioning" {
  bucket = aws_s3_bucket.audit_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

# The audit bucket logs to itself to prevent flags
resource "aws_s3_bucket_logging" "audit_logs_logging" {
  bucket        = aws_s3_bucket.audit_logs.id
  target_bucket = aws_s3_bucket.audit_logs.id
  target_prefix = "self-logs/"
}

# Enable logging on our main secure bucket
resource "aws_s3_bucket_logging" "secure_data_logging" {
  bucket        = aws_s3_bucket.secure_data.id
  target_bucket = aws_s3_bucket.audit_logs.id
  target_prefix = "secure-data-logs/"
}

```

