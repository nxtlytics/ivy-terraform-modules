# Configure the Azure Provider
provider "azurerm" {
  version = "=2.2.0"

  features {
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }
}

provider "random" {
  version = "~> 2.2"
}

# Intentionally empty. Will be filled by Terragrunt.
terraform {
  backend "azurerm" {}
}
