variable "service_accounts" {
  type = list(object({
    name                 = string,
    role                 = string,
    enabled              = optional(bool)
    password_store_paths = optional(list(string))
  }))
  default = []
}

variable "password_store_paths" {
  type        = list(string)
  default     = []
  description = "Password storage path"
}
