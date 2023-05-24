terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.48.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.36.0"
    }

  }
}
provider "azurerm" {
  skip_provider_registration = true
  features {
  }
}