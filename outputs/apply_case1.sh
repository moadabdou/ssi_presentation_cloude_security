
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
