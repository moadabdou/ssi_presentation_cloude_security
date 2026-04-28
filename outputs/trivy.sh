
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


