terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  tags = {
    env                = var.env
    workload           = "aiops"
    owner              = var.owner
    costCenter         = var.cost_center
    dataClassification = "internal"
    managedBy          = "terraform"
  }
}

module "rg_main" {
  source   = "../../modules/resource-group"
  name     = "rg-aiops-${var.env}-${var.region_code}-001"
  location = var.location
  tags     = local.tags
}
module "storage" {
  source              = "../../modules/storage"
  resource_group_name = module.rg_main.name
  location            = var.location
  env                 = var.env
  workload            = "aiops"
  region_code         = var.region_code
  tags                = local.tags
}
data "azurerm_client_config" "current" {}

module "keyvault" {
  source                   = "../../modules/keyvault"
  resource_group_name      = module.rg_main.name
  location                 = var.location
  env                      = var.env
  workload                 = "aiops"
  region_code              = var.region_code
  tenant_id                = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled = var.keyvault_purge_protection
  tags                     = local.tags
}
