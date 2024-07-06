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
| [grafana_service_account.account](https://registry.terraform.io/providers/grafana/grafana/3.2.1/docs/resources/service_account) | resource |
| [grafana_service_account_token.token](https://registry.terraform.io/providers/grafana/grafana/3.2.1/docs/resources/service_account_token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_accounts"></a> [service\_accounts](#input\_service\_accounts) | n/a | <pre>list(object({<br>    name    = string,<br>    role    = string,<br>    enabled = optional(bool)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_accounts"></a> [service\_accounts](#output\_service\_accounts) | n/a |
<!-- END_TF_DOCS -->