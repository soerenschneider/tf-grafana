locals {
  roleEditor = "Editor"
  roleAdmin  = "Admin"
}

resource "grafana_service_account" "annotations" {
  name        = "annotations sa"
  role        = local.roleEditor
  is_disabled = false
}

resource "grafana_service_account_token" "annotations" {
  name               = "annotations"
  service_account_id = grafana_service_account.annotations.id
}