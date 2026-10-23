terraform {
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

# Suffisso random per evitare collisioni globali sul nome del vault.
# Le Key Vault hanno nomi globalmente unici: senza suffisso, nomi
# deterministici (kv-aiops-dev-weu-001) possono essere gia' presi da altri tenant.
resource "random_integer" "kv_suffix" {
  min = 1000
  max = 9999

  keepers = {
    env  = var.env
    name = "kv-${var.workload}-${var.env}-${var.region_code}"
  }
}

resource "azurerm_key_vault" "this" {
  name                          = "kv-${var.workload}-${var.env}-${var.region_code}-${random_integer.kv_suffix.result}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  rbac_authorization_enabled    = true
  purge_protection_enabled      = var.purge_protection_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days
  public_network_access_enabled = true

  # TODO Step 9: hardening con private endpoint + default_action = "Deny"
  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags
}
