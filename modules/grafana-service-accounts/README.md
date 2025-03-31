<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | 3.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 3.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [grafana_service_account.account](https://registry.terraform.io/providers/grafana/grafana/3.22.0/docs/resources/service_account) | resource |
| [grafana_service_account_token.token](https://registry.terraform.io/providers/grafana/grafana/3.22.0/docs/resources/service_account_token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_password_store_paths"></a> [password\_store\_paths](#input\_password\_store\_paths) | Paths to write the credentials to. | `list(string)` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | n/a | <pre>object({<br/>    name    = string,<br/>    role    = string,<br/>    enabled = optional(bool)<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_password_store_paths"></a> [password\_store\_paths](#output\_password\_store\_paths) | n/a |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | n/a |
<!-- END_TF_DOCS -->