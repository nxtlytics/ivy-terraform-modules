locals {
  service   = "storagecontainer"
  base_name = join("", [var.environment, title(local.service)])
  tags      = merge(module.labels.tags, data.azurerm_resource_group.this.tags, var.tags)
}

module "labels" {
  source      = "../../common/tags/"
  namespace   = var.namespace
  sysenv      = var.sysenv
  environment = var.environment
  service     = local.service
  team_email  = var.team_email
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_storage_account" "this" {
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_storage_container" "this" {
  name                  = var.name
  storage_account_name  = data.azurerm_storage_account.this.name
  container_access_type = var.container_access_type
}
