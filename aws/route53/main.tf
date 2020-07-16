module "labels" {
  source      = "../../common/tags/"
  namespace   = var.namespace
  sysenv      = var.sysenv
  environment = var.environment
  service     = local.service
  team_email  = var.team_email
}

locals {
  service   = "route53"
  base_name = join("", [var.environment, title(local.service)])
  tags      = merge(module.labels.tags, var.tags)
}

resource "aws_route53_zone" "this" {
  count   = var.vpc_id == "" ? 1 : 0
  name    = var.domain
  comment = var.description
  tags    = local.tags
}

resource "aws_route53_zone" "private" {
  count   = var.vpc_id == "" ? 0 : 1
  name    = var.domain
  comment = var.description
  tags    = local.tags

  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "alias" {
  count   = length(var.alias["names"]) > 0 ? length(var.alias["names"]) : 0
  zone_id = var.vpc_id == "" ? aws_route53_zone.this.*.zone_id[0] : aws_route53_zone.private.*.zone_id[0]
  name    = "${element(var.alias["names"], count.index)}.${var.domain}"
  type    = element(var.alias["types"], count.index)

  alias {
    name                   = element(var.alias["values"], count.index)
    zone_id                = element(var.alias["zones_id"], count.index)
    evaluate_target_health = false
  }

}

resource "aws_route53_record" "non_alias" {
  count   = length(var.non_alias["names"]) > 0 ? length(var.non_alias["names"]) : 0
  zone_id = var.vpc_id == "" ? aws_route53_zone.this.*.zone_id[0] : aws_route53_zone.private.*.zone_id[0]
  name    = "${element(var.non_alias["names"], count.index)}.${var.domain}"
  type    = element(var.non_alias["types"], count.index)
  ttl     = element(var.non_alias["ttls"], count.index)
  records = split(",", element(var.non_alias["values"], count.index))
}
