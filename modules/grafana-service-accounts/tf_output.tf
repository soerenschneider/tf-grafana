output "service_account" {
  value = {
    name  = grafana_service_account.account.name
    token = grafana_service_account_token.token.key
  }
  sensitive = true
}

output "password_store_paths" {
  value = var.password_store_paths
}
