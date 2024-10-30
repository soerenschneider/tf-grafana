variable "service_account" {
  type = object({
    name    = string,
    role    = string,
    enabled = optional(bool)
  })

  validation {
    condition     = length(var.service_account.name) >= 5
    error_message = "Service account name should be at least 5 characters"
  }

  validation {
    condition     = contains(["Admin", "Editor", "Viewer"], var.service_account.role)
    error_message = "The role must be one of the following: 'Admin', 'Editor', or 'Viewer'."
  }
}

variable "password_store_paths" {
  type        = list(string)
  description = "Paths to write the credentials to."
}
