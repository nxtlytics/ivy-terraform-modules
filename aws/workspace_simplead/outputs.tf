output "aws_directory_service_directory-this-name" {
  value       = aws_directory_service_directory.this.name
  description = "The fully qualified name for the directory, such as `corp.example.com`"
}

output "aws_directory_service_directory-this-id" {
  value       = aws_directory_service_directory.this.id
  description = "The directory identifier"
}

output "aws_directory_service_directory-this-username" {
  value       = "Administrator"
  description = "The directory identifier"
}

output "aws_directory_service_directory-this-password" {
  value       = aws_directory_service_directory.this.password
  description = "The directory identifier"
  sensitive   = true
}

output "aws_directory_service_directory-this-access_url" {
  value       = aws_directory_service_directory.this.access_url
  description = "The access URL for the directory, such as `http://alias.awsapps.com`"
}

output "aws_directory_service_directory-this-dns_ip_addresses" {
  value       = aws_directory_service_directory.this.dns_ip_addresses
  description = "A list of IP addresses of the DNS servers for the directory or connector"
}

output "aws_directory_service_directory-this-security_group_id" {
  value       = aws_directory_service_directory.this.security_group_id
  description = "The ID of the security group created by the directory"
}

output "aws_workspaces_directory-this-id" {
  value       = aws_workspaces_directory.this.id
  description = "The WorkSpaces directory identifier"
}
