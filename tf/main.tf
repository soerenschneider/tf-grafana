terraform {
  required_version = "~> 1.0"
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "~> 1.13"
    }
  }

  backend "s3" {
    bucket               = "soerenschneider-terraform"
    key                  = "grafana"
    workspace_key_prefix = "grafana"
    region               = "us-east-1"
  }
}

provider "grafana" {
}
