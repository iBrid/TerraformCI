terraform {
  // required_version = ">=1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.43.0"
    }
  }
  #Linking to Terraform Cloud
  cloud {
    organization = "DatacentR"
    workspaces {
      name = "TerraformCI"
    }
  }
}

/*#using azure key vault for client_id
data "azurerm_key_vault_secret" "client_id" {
  name = "clientid"
  key_vault_id = "/subscriptions/5822ccc3-d8c7-4df7-9bcd-11dfde97ab0b/resourceGroups/myTrainingLab/providers/Microsoft.KeyVault/vaults/myterraformkey"
}

#using azure key vault for client secret
data "azurerm_key_vault_secret" "client_secret" {
  name = "clientsecret"
  key_vault_id = "/subscriptions/5822ccc3-d8c7-4df7-9bcd-11dfde97ab0b/resourceGroups/myTrainingLab/providers/Microsoft.KeyVault/vaults/myterraformkey"
} */

provider "azurerm" {
  features {}
  /*client_id                  = var.client_id
  client_secret              = var.client_secret
  tenant_id                  = var.tenant_id*/
  subscription_id            = "/subscriptions/5822ccc3-d8c7-4df7-9bcd-11dfde97ab0b"
  skip_provider_registration = true
}

resource "azurerm_resource_group" "rg" {
  name     = "myTrainingLab1"
  location = "West US 2"
}

resource "azurerm_storage_account" "storage" {
  name                     = "mtlstgacct023"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
