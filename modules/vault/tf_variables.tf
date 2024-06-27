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

variable "vault_path_prefix" {
  type    = string
  default = "grafana"

  validation {
    condition     = length(var.vault_path_prefix) >= 3 && !strcontains(var.vault_path_prefix, "/")
    error_message = "vault_path_prefix must be more than 2 characters and must not contain slashes."
  }
}

variable "env" {
  type        = string
  description = "Used to build the path of the secret."

  validation {
    condition     = length(var.env) >= 3 && !strcontains(var.env, "/")
    error_message = "env must be more than 2 characters and must not contain slashes."
  }
}

variable "metadata" {
  type        = map(any)
  default     = null
  description = "Optional metadata to attach to the secret."
}
