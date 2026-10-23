variable "resource_group_name" {
  description = "RG in cui creare il Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "env" {
  description = "Ambiente (dev, test, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.env)
    error_message = "env deve essere dev, test o prod."
  }
}

variable "workload" {
  description = "Workload prefix (aiops)"
  type        = string
  default     = "aiops"
}

variable "region_code" {
  description = "Short region code (weu, itn, ...)"
  type        = string
  default     = "weu"
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "purge_protection_enabled" {
  description = "Abilita purge protection (irreversibile). true in prod, false altrove."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention (7-90 giorni)"
  type        = number
  default     = 7
  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days deve essere tra 7 e 90."
  }
}

variable "tags" {
  description = "Tag da applicare"
  type        = map(string)
  default     = {}
}
