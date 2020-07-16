locals {
  service   = "storageaccount"
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

resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags                     = local.tags
}
