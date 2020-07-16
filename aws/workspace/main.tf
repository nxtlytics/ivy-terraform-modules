module "labels" {
  source      = "../../common/tags"
  namespace   = var.namespace
  sysenv      = var.sysenv
  environment = var.environment
  service     = local.service
  team_email  = var.team_email
}

locals {
  service   = "workspace"
  base_name = join("", [var.environment, title(local.service)])
  tags      = merge(module.labels.tags, var.tags)
}

data "aws_workspaces_bundle" "this" {
  bundle_id = var.bundles[var.bundle_name]
}

data "aws_ssm_parameter" "this" {
  name = "/${var.environment}/workspaces/${var.username}"
}

# data.terraform_remote_state.ad is declared in config.tf
resource "ad_user" "this" {
  domain     = data.terraform_remote_state.ad.outputs.aws_directory_service_directory-this-name
  first_name = upper(var.username)
  last_name  = upper(var.username)
  logon_name = var.username
  email      = var.email
  password   = data.aws_ssm_parameter.this.value
}

resource "aws_workspaces_workspace" "this" {
  directory_id                   = data.terraform_remote_state.ad.outputs.aws_directory_service_directory-this-id
  bundle_id                      = data.aws_workspaces_bundle.this.id
  user_name                      = ad_user.this.logon_name
  tags                           = local.tags
  root_volume_encryption_enabled = var.root_volume_encryption_enabled
  user_volume_encryption_enabled = var.user_volume_encryption_enabled
  volume_encryption_key          = var.volume_encryption_key

  workspace_properties {
    compute_type_name                         = var.compute_type_name
    user_volume_size_gib                      = var.user_volume_size_gib
    root_volume_size_gib                      = var.root_volume_size_gib
    running_mode                              = var.running_mode
    running_mode_auto_stop_timeout_in_minutes = var.running_mode_auto_stop_timeout_in_minutes
  }
}
