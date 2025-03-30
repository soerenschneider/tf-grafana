service_accounts = [
  {
    name                 = "flux-svc.pt",
    role                 = "Editor"
    password_store_paths = ["soeren.cloud/k8s/svc.pt.soeren.cloud/grafana/%s"]
  }
]
