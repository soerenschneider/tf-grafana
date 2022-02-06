
variable "dashboards" {
  type = list(object({
    folder_title = string
    folder       = string
  }))
}
