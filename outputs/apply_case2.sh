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
