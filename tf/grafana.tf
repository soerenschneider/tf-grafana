module "dashboards" {
  for_each     = { for dir in var.dashboards : dir.folder => dir }
  source       = "./dashboards"
  folder_title = each.value.folder_title
  folder       = "${path.module}/../dashboards/${each.value.folder}"
}

