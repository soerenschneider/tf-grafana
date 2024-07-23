locals {
  env     = basename(abspath(path.module))
  folders = toset(flatten([for _, v in flatten(fileset(path.module, "../../dashboards/**")) : regex("^../../dashboards/([[:alnum:]]+)", v)]))
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
  source           = "../../modules/grafana-service-accounts"
  service_accounts = var.service_accounts
}

module "vault" {
  source           = "../../modules/vault"
  service_accounts = nonsensitive(module.service_accounts.service_accounts)
  path_prefix      = "env/${local.env}/grafana"
}
