resource "grafana_folder" "folder" {
  title = var.folder_title
}

resource "grafana_dashboard" "dashboard" {
  for_each = fileset(var.folder, "*.json")

  config_json = file("${var.folder}/${each.value}")
  folder      = grafana_folder.folder.id
}
