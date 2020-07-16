output "azurerm_storage_container-this-id" {
  value       = azurerm_storage_container.this.id
  description = "ID for this storage account"
}

output "azurerm_storage_container-this-has_immutability_policy" {
  value       = azurerm_storage_container.this.has_immutability_policy
  description = "Is there an Immutability Policy configured on this Storage Container?"
}

output "azurerm_storage_container-this-has_legal_hold" {
  value       = azurerm_storage_container.this.has_legal_hold
  description = "Is there a Legal Hold configured on this Storage Container?"
}
