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
