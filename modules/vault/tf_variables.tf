variable "service_accounts" {
  type = list(
    object({
      name  = string,
      token = string
  }))

  validation {
    condition     = alltrue([for x in var.service_accounts : length(x.name) > 3 && length(x.token) >= 20])
    error_message = "vault_kv2_mount should not end with a slash."
  }
}

variable "vault_kv2_mount" {
  type    = string
  default = "secret"

  validation {
    condition     = !endswith(var.vault_kv2_mount, "/") && length(var.vault_kv2_mount) > 3
    error_message = "vault_kv2_mount should not end with a slash."
  }
}

variable "path_prefix" {
  type    = string
  default = "grafana"

  validation {
    condition     = length(var.path_prefix) >= 3
    error_message = "path_prefix must be more than 2 characters."
  }

  validation {
    condition     = !(startswith(var.path_prefix, "/") || endswith(var.path_prefix, "/"))
    error_message = "Invalid path_prefix: must not start or end with a slash ('/')."
  }
}

variable "metadata" {
  type        = map(any)
  default     = null
  description = "Optional metadata to attach to the secret."
}
