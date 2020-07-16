output "ad_user-this-logon_name" {
  value       = ad_user.this.logon_name
  description = "Active Directory Username for this workspace"
}

#output "aws_iam_user-this-name" {
#  value       = aws_iam_user.this.name
#  description = "Name for this IAM user"
#}
#
#output "aws_iam_user-this-unique_id" {
#  value       = aws_iam_user.this.unique_id
#  description = "Unique ID for this IAM user"
#}
#
#output "aws_iam_user_policy-this-id" {
#  value       = aws_iam_user_policy.this.id
#  description = "ID for this IAM user policy, in the form of `user_name:user_policy_name`"
#}
#
#output "aws_iam_user_policy-this-name" {
#  value       = aws_iam_user_policy.this.name
#  description = "Name for this IAM user policy"
#}
