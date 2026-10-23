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
