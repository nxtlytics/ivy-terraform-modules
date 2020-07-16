output "aws_iam_role-this-arn" {
  value       = aws_iam_role.this.arn
  description = "Amazon Resource Name for this IAM role"
}

output "aws_iam_role-this-name" {
  value       = aws_iam_role.this.name
  description = "Name for this IAM role"
}

output "aws_iam_role-this-unique_id" {
  value       = aws_iam_role.this.unique_id
  description = "Unique ID for this IAM role"
}
