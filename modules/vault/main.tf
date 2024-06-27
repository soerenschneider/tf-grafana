resource "vault_kv_secret_v2" "tokens" {
  for_each            = { for i, val in var.service_accounts : i => val }
  mount               = var.vault_kv2_mount
  name                = "${var.vault_path_prefix}/${var.env}/serviceaccounts/${each.value.name}"
  delete_all_versions = true
  data_json = jsonencode(
    {
      token = each.value.token,
    }
  )
  custom_metadata {
    max_versions = 1
    data         = var.metadata
  }
}
