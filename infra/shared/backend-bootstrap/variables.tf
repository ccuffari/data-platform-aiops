variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "region_code" {
  description = "Short region code (weu, itn, ...)"
  type        = string
  default     = "weu"
}

variable "owner" {
  description = "Owner tag value (email o team)"
  type        = string
}

variable "cost_center" {
  description = "Cost center tag value"
  type        = string
}

variable "cicd_sp_object_id" {
  description = "Object ID del Service Principal CI/CD a cui dare accesso allo state"
  type        = string
}
