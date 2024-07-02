variable "service_accounts" {
  type = list(object({
    name    = string,
    role    = string,
    enabled = optional(bool)
  }))

  validation {
    condition     = alltrue([for x in var.service_accounts : length(x.name) >= 5])
    error_message = "Service account name should be at least 5 characters"
  }

  validation {
    condition     = alltrue([for x in var.service_accounts : contains(["Admin", "Editor", "Viewer"], x.role)])
    error_message = "The role must be one of the following: 'Admin', 'Editor', or 'Viewer'."
  }
}
