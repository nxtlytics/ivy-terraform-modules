output "tags" {
  value       = local.tags
  description = "Normalized Tag map."
}

output "tags_asg_format" {
  value       = local.tags_asg_format
  description = "Tags in the AWS AutoScaling Group format."
}
