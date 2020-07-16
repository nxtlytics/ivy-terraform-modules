module "labels" {
  source      = "../../common/tags/"
  namespace   = var.namespace
  sysenv      = var.sysenv
  environment = var.environment
  service     = local.service
  team_email  = var.team_email
}

locals {
  service   = "s3"
  base_name = join("", [var.environment, title(local.service)])
  tags      = merge(module.labels.tags, var.tags)
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl
  tags   = local.tags
  region = var.region

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.custom_statement == "" ? 0 : 1
  bucket = aws_s3_bucket.this.id
  policy = var.custom_statement
  depends_on = [
    aws_s3_bucket_public_access_block.this,
  ]
}
