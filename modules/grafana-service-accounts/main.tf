resource "grafana_service_account" "account" {
  for_each    = { for x in var.service_accounts : x.name => x }
  name        = each.key
  role        = each.value.role
  is_disabled = each.value.enabled
}

resource "grafana_service_account_token" "token" {
  for_each           = { for x in var.service_accounts : x.name => x }
  name               = each.key
  service_account_id = grafana_service_account.account[each.key].id
}
