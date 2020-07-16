output "aws_acm_certificate-this-unique_id" {
  value       = aws_acm_certificate.this.id
  description = "Unique ID for this ACM Certificate"
}

output "aws_acm_certificate-this-arn" {
  value       = aws_acm_certificate.this.arn
  description = "Amazon Resource Name for this ACM Certificate"
}

output "aws_acm_certificate-this-domain_name" {
  value       = aws_acm_certificate.this.domain_name
  description = "The domain name for which the certificate is issued"
}

output "aws_acm_certificate-this-domain_validation_options" {
  value       = aws_acm_certificate.this.domain_validation_options
  description = "ID for this IAM user policy, in the form of `user_name:user_policy_name`"
}

output "aws_acm_certificate_policy-this-validation_emails" {
  value       = aws_acm_certificate.this.validation_emails
  description = "A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used."
}
