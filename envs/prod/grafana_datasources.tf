resource "grafana_data_source" "victoriametrics" {
  type               = "prometheus"
  name               = "victoriametrics"
  url                = "https://victoriametrics.rs.soeren.cloud"
  basic_auth_enabled = false
  is_default         = true
}

resource "grafana_data_source" "prometheus-dd" {
  type               = "prometheus"
  name               = "prometheus-dd"
  url                = "https://monitoring.svc.dd.soeren.cloud/prometheus"
  basic_auth_enabled = false
}

resource "grafana_data_source" "prometheus-ez" {
  type               = "prometheus"
  name               = "prometheus-ez"
  url                = "https://monitoring.svc.ez.soeren.cloud/prometheus"
  basic_auth_enabled = false
}