output "azurerm_linux_virtual_machine-this-id" {
  value       = azurerm_linux_virtual_machine.this.id
  description = "ID for this virtual machine"
}

output "azurerm_linux_virtual_machine-this-name" {
  value       = local.computer_name
  description = "Computer Name of this Virtual Machine"
}

output "azurerm_linux_virtual_machine-this-fqdn" {
  value       = local.fqdn
  description = "Fully Qualified Domain Name of this Virtual Machine"
}

output "azurerm_linux_virtual_machine-this-location" {
  value       = data.azurerm_resource_group.this.location
  description = "Location of this Virtual Machine"
}

output "azurerm_linux_virtual_machine-this-private_ipv4" {
  value       = azurerm_network_interface.this.private_ip_address
  description = "Private IPv4 of this Virtual Machine"
}
