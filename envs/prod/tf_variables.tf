variable "grafana_auth" {
  type = string
}

variable "service_accounts" {
  type = list(object({
    name    = string,
    role    = string,
    enabled = optional(bool)
  }))
  default = []
}
