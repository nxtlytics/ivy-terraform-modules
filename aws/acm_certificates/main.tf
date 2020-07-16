module "labels" {
  source      = "../../common/tags/"
  namespace   = var.namespace
  sysenv      = var.sysenv
  environment = var.environment
  service     = local.service
  team_email  = var.team_email
}

locals {
  service   = "acm-certificate"
  base_name = join("", [var.environment, title(local.service)])
  tags      = merge(module.labels.tags, var.tags)
}

resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  validation_method         = var.validation_method
  tags                      = local.tags
  subject_alternative_names = var.subject_alternative_names

  lifecycle {
    create_before_destroy = true
  }
}
