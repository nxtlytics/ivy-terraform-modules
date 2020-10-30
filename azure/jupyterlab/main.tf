locals {
  service   = "jupyterlab"
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

data "azurerm_subscription" "this" {
  subscription_id = var.subscription_id
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "this" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = data.azurerm_resource_group.this.name
}

resource "azurerm_network_security_group" "this" {
  name                = "${local.base_name}-NetworkSecurityGroup"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  tags                = local.tags

  security_rule {
    name                       = "SSH-INTERNAL"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DOCKER-TCP-SOCKET"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2376"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "INTERNET-ALL-PING"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "VPN-ALL-TRAFFIC"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.vpn_supernet
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ALL-OUTBOUND"
    priority                   = 1007
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "this" {
  name                 = "${local.base_name}-NIC"
  location             = data.azurerm_resource_group.this.location
  resource_group_name  = data.azurerm_resource_group.this.name
  enable_ip_forwarding = "true"
  tags                 = local.tags

  ip_configuration {
    name                          = "${local.base_name}-NicConfiguration"
    subnet_id                     = data.azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

# Start of diagnostics dependencies
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = data.azurerm_resource_group.this.name
  }

  byte_length = 8
}

resource "azurerm_storage_account" "this" {
  name                     = "diag${random_id.randomId.hex}"
  location                 = data.azurerm_resource_group.this.location
  resource_group_name      = data.azurerm_resource_group.this.name
  account_replication_type = "LRS"
  account_tier             = "Standard"
  tags                     = local.tags
}

resource "azurerm_storage_container" "this" {
  name                  = "${var.namespace}-${var.environment}-${local.service}"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
# End of diagnostics dependencies

locals {
  ip_address_dash = replace(azurerm_network_interface.this.private_ip_address, ".", "-")
  computer_name   = "${local.service}-${local.ip_address_dash}"
  fqdn            = "${local.computer_name}.node.${var.environment}.${var.namespace}"
}

resource "azurerm_linux_virtual_machine" "this" {
  name                            = local.base_name
  location                        = data.azurerm_resource_group.this.location
  resource_group_name             = data.azurerm_resource_group.this.name
  network_interface_ids           = [azurerm_network_interface.this.id]
  size                            = var.vm_size
  computer_name                   = local.computer_name
  disable_password_authentication = true
  admin_username                  = var.admin_user
  tags                            = local.tags

  admin_ssh_key {
    username   = var.admin_user
    public_key = var.admin_user_public_ssh_key
  }

  os_disk {
    name                      = "${local.base_name}-OsDisk"
    caching                   = "ReadWrite"
    disk_size_gb              = 30
    storage_account_type      = "Standard_LRS"
    write_accelerator_enabled = false
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS-CI"
    sku       = "7-CI"
    version   = "7.7.20191209"
  }

  custom_data = base64encode(templatefile(
    "${path.module}/custom_data.tpl",
    {
      namespace            = var.namespace,
      service              = local.service,
      name                 = local.computer_name,
      storage_container_id = azurerm_storage_container.this.id,
      prompt_color         = var.prompt_color
      csv_mounts           = var.csv_mounts
  }))

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.this.primary_blob_endpoint
  }

  identity {
    type = "SystemAssigned"
  }

}

data "azurerm_role_definition" "this" {
  name = "Storage Blob Data Reader"
}

resource "azurerm_role_assignment" "this" {
  scope              = azurerm_storage_account.this.id
  role_definition_id = "${data.azurerm_subscription.this.id}${data.azurerm_role_definition.this.id}"
  principal_id       = azurerm_linux_virtual_machine.this.identity[0].principal_id
}
