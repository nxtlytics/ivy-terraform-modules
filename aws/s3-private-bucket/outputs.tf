output "aws_s3_bucket-this-id" {
  value       = aws_s3_bucket.this.id
  description = "The name of this bucket"
}

output "aws_s3_bucket-this-arn" {
  value       = aws_s3_bucket.this.arn
  description = "The Amazon Resource Name (ARN) of this bucket"
}

output "aws_s3_bucket-this-region" {
  value       = aws_s3_bucket.this.region
  description = "Region where this bucket is located"
}
