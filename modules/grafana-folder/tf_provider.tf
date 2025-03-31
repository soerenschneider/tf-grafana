terraform {
  required_version = ">= 1.7.0"
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "3.22.0"
    }
  }
}
