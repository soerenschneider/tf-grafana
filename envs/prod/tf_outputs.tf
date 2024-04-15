output "token" {
  value     = grafana_service_account_token.annotations.key
  sensitive = true
}