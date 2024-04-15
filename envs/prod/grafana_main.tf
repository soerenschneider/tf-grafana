locals {
  folders = toset(flatten([for _, v in flatten(fileset(path.module, "../../dashboards/**")) : regex("^../../dashboards/([[:alnum:]]+)", v)]))
  dashboards = {
    for _, folder in local.folders : folder => fileset(abspath(path.module), "../../dashboards/${folder}/*.json")
  }
}

module "folders" {
  for_each        = local.dashboards
  source          = "../../modules/folder"
  folder_name     = each.key
  dashboard_files = each.value
}