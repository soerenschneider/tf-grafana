terraform {
  required_version = ">= 1.7.0"
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

  encryption {
    method "aes_gcm" "default" {
      keys = key_provider.pbkdf2.mykey
    }

    state {
      enforced = true
      method   = method.aes_gcm.default
    }
    plan {
      method   = method.aes_gcm.default
      enforced = true
    }
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
