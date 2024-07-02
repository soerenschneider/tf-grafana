resource "grafana_folder" "folder" {
  title = var.folder_name
}

resource "grafana_dashboard" "dashboard" {
  for_each    = var.dashboard_files
  folder      = grafana_folder.folder.id
  config_json = file(each.value)
}