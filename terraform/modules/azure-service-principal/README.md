<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.65 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 1.6.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.73.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage name. Use one of (test\|prod) | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ARM_CLIENT_ID"></a> [ARM\_CLIENT\_ID](#output\_ARM\_CLIENT\_ID) | n/a |
| <a name="output_ARM_CLIENT_SECRET"></a> [ARM\_CLIENT\_SECRET](#output\_ARM\_CLIENT\_SECRET) | n/a |
| <a name="output_ARM_SUBSCRIPTION_ID"></a> [ARM\_SUBSCRIPTION\_ID](#output\_ARM\_SUBSCRIPTION\_ID) | n/a |
| <a name="output_ARM_TENANT_ID"></a> [ARM\_TENANT\_ID](#output\_ARM\_TENANT\_ID) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
