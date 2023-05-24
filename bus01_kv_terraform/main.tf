locals {
  target_resource_group = "rg-local-tf-sbx-001"
}
data "azurerm_resource_group" "example" {
  name = local.target_resource_group
}

data "azurerm_client_config" "current" {}

data "azuread_group" "bushey" {
  display_name = "Pod Bushey"
}

data "azuread_group" "mor" {
  display_name = "Pod Mornington Crescent"
}

data "azuread_group" "cry" {
  display_name = "Pod Crystal Palace"
}

data "azuread_application" "dev" {
  display_name = "ce05-Azure-Terraform-dev"
}

resource "azurerm_key_vault" "target" {
  name                = "kv-ce05-bus01-dev"
  location            = "northeurope"
  resource_group_name = data.azurerm_resource_group.example.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_group.bushey.object_id

    secret_permissions = ["Get", "List", "Set"]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_group.mor.object_id

    secret_permissions = ["List"]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_group.cry.object_id

    secret_permissions = ["List"]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_application.dev.object_id

    secret_permissions = ["List"]
  }

}
