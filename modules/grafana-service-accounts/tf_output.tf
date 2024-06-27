output "service_accounts" {
  value = [for i in var.service_accounts :
    {
      name  = i.name,
      token = grafana_service_account_token.token[i.name].key
    }
  ]
  sensitive = true
}
