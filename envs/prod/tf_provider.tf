terraform {
  required_version = ">= 1.7.0"
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "3.22.1"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "4.7.0"
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
  address = "https://vault.ha.soeren.cloud"
}

provider "grafana" {
  url = "https://grafana.svc.pt.soeren.cloud"
}
