terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
}

# Suffisso random per garantire unicità globale del nome Storage Account
resource "random_integer" "sa_suffix" {
  min = 1000
  max = 9999
}

locals {
  tags = {
    env                = "shared"
    workload           = "aiops"
    owner              = var.owner
    costCenter         = var.cost_center
    dataClassification = "internal"
    managedBy          = "terraform"
  }
  sa_name = "sttfstateaiops${var.region_code}${random_integer.sa_suffix.result}"
}

resource "azurerm_resource_group" "tfstate" {
  name     = "rg-tfstate-aiops-${var.region_code}-001"
  location = var.location
  tags     = local.tags
}

resource "azurerm_storage_account" "tfstate" {
  name                            = local.sa_name
  resource_group_name             = azurerm_resource_group.tfstate.name
  location                        = azurerm_resource_group.tfstate.location
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true # backend Terraform da CI: rete pubblica

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 30
    }
  }

  tags = local.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

# Il SP di CI/CD deve poter leggere e scrivere lo state (data plane)
resource "azurerm_role_assignment" "sp_state_rw" {
  scope                = azurerm_storage_container.tfstate.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.cicd_sp_object_id
}
