terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "3.2.1"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "4.2.0"
    }
  }

  backend "s3" {
    bucket = "soerenschneider-terraform"
    key    = "grafana-prd"
    region = "us-east-1"
  }
}

provider "vault" {
  address = "http://localhost:8200"
  token   = "test"
}

provider "grafana" {
  url  = "http://localhost:3000"
  auth = "admin:admin"
}
