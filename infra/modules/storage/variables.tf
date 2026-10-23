variable "resource_group_name" {
  description = "RG in cui creare la SA"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "env" {
  description = "Ambiente (dev, test, prod)"
  type        = string
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

variable "tags" {
  description = "Tag da applicare"
  type        = map(string)
  default     = {}
}
