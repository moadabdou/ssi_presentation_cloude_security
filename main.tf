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