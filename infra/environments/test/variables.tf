variable "env" {
  description = "Ambiente (dev, test, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.env)
    error_message = "env deve essere dev, test o prod."
  }
}

variable "region_code" {
  description = "Codice breve region (weu, itn, ...)"
  type        = string
  default     = "weu"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "owner" {
  description = "Owner tag"
  type        = string
}

variable "cost_center" {
  description = "Cost center tag"
  type        = string
}
