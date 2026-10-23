variable "name" {
  description = "Nome del Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tag da applicare"
  type        = map(string)
  default     = {}
}
