terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "2.14.3"
    }
  }

  backend "s3" {
    bucket = "soerenschneider-terraform"
    key    = "grafana-prd"
    region = "us-east-1"
  }
}

provider "grafana" {
  url  = "https://grafana.soeren.cloud"
  auth = var.grafana_auth
}