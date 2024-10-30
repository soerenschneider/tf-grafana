resource "grafana_service_account" "account" {
  name        = var.service_account.name
  role        = var.service_account.role
  is_disabled = try(!var.service_account.enabled, false)
}

resource "grafana_service_account_token" "token" {
  name               = var.service_account.name
  service_account_id = grafana_service_account.account.id
}
