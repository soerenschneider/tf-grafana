<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | 3.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 3.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [grafana_dashboard.dashboard](https://registry.terraform.io/providers/grafana/grafana/3.2.1/docs/resources/dashboard) | resource |
| [grafana_folder.folder](https://registry.terraform.io/providers/grafana/grafana/3.2.1/docs/resources/folder) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dashboard_files"></a> [dashboard\_files](#input\_dashboard\_files) | n/a | `set(string)` | n/a | yes |
| <a name="input_folder_name"></a> [folder\_name](#input\_folder\_name) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->