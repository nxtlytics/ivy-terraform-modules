output "azurerm_storage_account-this-id" {
  value       = azurerm_storage_account.this.id
  description = "ID for this storage account"
}

output "azurerm_storage_account-this-identity" {
  value       = azurerm_storage_account.this.identity
  description = "An `identity` block as defined below, which contains the Identity information for this Storage Account."
}

output "azurerm_storage_account-this-primary_location" {
  value       = azurerm_storage_account.this.primary_location
  description = "The primary location of the storage account."
}
