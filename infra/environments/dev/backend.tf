terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-aiops-weu-001"
    storage_account_name = "sttfstateaiopsweu5502"
    container_name       = "tfstate"
    key                  = "dev.data-platform-aiops.tfstate"
    use_azuread_auth     = true
  }
}
