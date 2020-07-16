output "aws_route53_zone-this-name" {
  value       = var.vpc_id == "" ? aws_route53_zone.this.*.name[0] : aws_route53_zone.private.*.name[0]
  description = "The Hosted Zone Name. This can be referenced by zone records."
}

output "aws_route53_zone-this-zone_id" {
  value       = var.vpc_id == "" ? aws_route53_zone.this.*.zone_id[0] : aws_route53_zone.private.*.zone_id[0]
  description = "The Hosted Zone ID. This can be referenced by zone records."
}

output "aws_route53_zone-this-name_servers" {
  value       = var.vpc_id == "" ? aws_route53_zone.this.*.name_servers[0] : aws_route53_zone.private.*.name_servers[0]
  description = "A list of name servers in associated (or default) delegation set."
}
