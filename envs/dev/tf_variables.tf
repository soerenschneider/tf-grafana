variable "service_accounts" {
  type = list(object({
    name    = string,
    role    = string,
    enabled = optional(bool)
  }))
  default = []
}
