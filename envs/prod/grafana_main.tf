locals {
  instance                     = basename(abspath(path.module))
  password_store_paths_default = ["env/${local.instance}/grafana/serviceaccount/%s"]
  folders                      = toset(flatten([for _, v in flatten(fileset(path.module, "../../dashboards/**")) : regex("^../../dashboards/([[:alnum:]]+)", v)]))
  dashboards = {
    for _, folder in local.folders : folder => fileset(abspath(path.module), "../../dashboards/${folder}/*.json")
  }
}

module "folders" {
  for_each        = local.dashboards
  source          = "../../modules/grafana-folder"
  folder_name     = each.key
  dashboard_files = each.value
}

module "service_accounts" {
  for_each             = { for sa in var.service_accounts : sa.name => sa }
  source               = "../../modules/grafana-service-accounts"
  service_account      = each.value
  password_store_paths = coalescelist(each.value.password_store_paths, var.password_store_paths, local.password_store_paths_default)
}

module "vault" {
  for_each             = module.service_accounts
  source               = "../../modules/vault"
  service_account      = nonsensitive(each.value.service_account)
  password_store_paths = coalescelist(each.value.password_store_paths, var.password_store_paths, local.password_store_paths_default)
  metadata             = {}
}
