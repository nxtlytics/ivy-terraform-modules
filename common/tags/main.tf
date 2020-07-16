provider "null" {
  version = "~> 2.1"
}

locals {
  namespace         = lower(format("%v", var.namespace))
  environment       = lower(format("%v", var.environment))
  sysenv            = lower(format("%v", var.sysenv))
  service           = lower(format("%v", var.service))
  service_namespace = lower(format("%v", var.service_namespace))
  consul_service    = join(var.delimiter, compact([local.service, local.service_namespace]))
  role              = lower(format("%v", var.role))
  createdby         = lower(format("%v", var.createdby))
  team_email        = lower(format("%v", var.team_email))

  tags = {
    "${local.namespace}:environment" = local.environment
    "${local.namespace}:sysenv"      = local.sysenv
    "${local.namespace}:service"     = local.consul_service
    "${local.namespace}:role"        = local.role == "" ? local.service : local.role
    "${local.namespace}:team"        = local.team_email
    "${local.namespace}:createdby"   = local.createdby
  }

  tags_asg_format = null_resource.tags_as_list_of_maps.*.triggers
}

resource "null_resource" "tags_as_list_of_maps" {
  count = length(keys(local.tags))

  triggers = {
    "key"                 = keys(local.tags)[count.index]
    "value"               = values(local.tags)[count.index]
    "propagate_at_launch" = "true"
  }
}
