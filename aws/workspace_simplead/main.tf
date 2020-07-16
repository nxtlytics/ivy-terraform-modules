module "labels" {
  source      = "../../common/tags"
  namespace   = var.namespace
  sysenv      = var.sysenv
  environment = var.environment
  service     = local.service
  team_email  = var.team_email
}

locals {
  service   = "service-directory"
  base_name = join("", [var.environment, title(local.service)])
  tags      = merge(module.labels.tags, var.tags)
}

data "aws_vpc" "this" {
  tags = {
    "Name" = var.environment
  }
}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.this.id

  filter {
    name   = "tag:${var.namespace}:role"
    values = ["PrivateSubnet1", "PrivateSubnet2"]
  }
}

data "aws_ssm_parameter" "this" {
  name = var.ssm_parameter
}

resource "aws_directory_service_directory" "this" {
  name     = var.name
  password = data.aws_ssm_parameter.this.value
  size     = var.size
  tags     = local.tags

  vpc_settings {
    vpc_id     = data.aws_vpc.this.id
    subnet_ids = data.aws_subnet_ids.this.ids
  }
}

resource "aws_workspaces_directory" "this" {
  directory_id = aws_directory_service_directory.this.id
  tags         = local.tags
  subnet_ids   = data.aws_subnet_ids.this.ids

  self_service_permissions {
    change_compute_type  = var.change_compute_type
    increase_volume_size = var.increase_volume_size
    rebuild_workspace    = var.rebuild_workspace
    restart_workspace    = var.restart_workspace
    switch_running_mode  = var.switch_running_mode
  }
}
