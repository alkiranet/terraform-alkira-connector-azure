# Alkira Azure Connector
Terraform module that provisions [Alkira Azure Connector](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_azure_vnet).

## Basic Usage
```hcl
module "connect_vnet" {
  source = "alkiranet/connector-azure/alkira"

  name              = "connector-east-dev"
  cxp               = "US-EAST-2"
  credential        = "azure-credential"
  segment           = "business"
  group             = "cloud"
  azure_vnet_id     = "123456789"
  vnet_cidr         = [{ cidr = "10.20.0.0/20" }]

}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_alkira"></a> [alkira](#requirement\_alkira) | >= 0.9.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alkira"></a> [alkira](#provider\_alkira) | >= 0.9.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alkira_connector_azure_vnet.connector](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_azure_vnet) | resource |
| [alkira_billing_tag.tag](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/billing_tag) | data source |
| [alkira_credential.credential](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/credential) | data source |
| [alkira_group.group](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/group) | data source |
| [alkira_policy_prefix_list.cidr_pfx](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/policy_prefix_list) | data source |
| [alkira_policy_prefix_list.subnet_pfx](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/policy_prefix_list) | data source |
| [alkira_segment.segment](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/segment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_vnet_id"></a> [azure\_vnet\_id](#input\_azure\_vnet\_id) | ID of Azure VNet that is being connected | `string` | n/a | yes |
| <a name="input_billing_tags"></a> [billing\_tags](#input\_billing\_tags) | Billing tags associated with connector | `list(string)` | `[]` | no |
| <a name="input_credential"></a> [credential](#input\_credential) | Name of credential to use for onboarding VNet | `string` | n/a | yes |
| <a name="input_cxp"></a> [cxp](#input\_cxp) | CXP to provision connector in | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Status of connector | `bool` | `true` | no |
| <a name="input_failover_cxps"></a> [failover\_cxps](#input\_failover\_cxps) | List of CXPs where connector should be provisioned for failover | `list(string)` | `[]` | no |
| <a name="input_group"></a> [group](#input\_group) | Group to associate with connector | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of connector | `string` | n/a | yes |
| <a name="input_segment"></a> [segment](#input\_segment) | Segment to provision connector in | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Size of connector | `string` | `"SMALL"` | no |
| <a name="input_vnet_cidr"></a> [vnet\_cidr](#input\_vnet\_cidr) | CIDR of Azure VNet that is being connected | <pre>list(object({<br>    cidr             = optional(string)<br>    prefix_lists     = optional(list(string), [])<br>    routing_options  = optional(string, "ADVERTISE_DEFAULT_ROUTE")<br>    service_tags     = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_vnet_subnet"></a> [vnet\_subnet](#input\_vnet\_subnet) | Subnets to onboard in place of entire VNet CIDR block | <pre>list(object({<br>    prefix_lists     = optional(list(string), [])<br>    routing_options  = optional(string, "ADVERTISE_DEFAULT_ROUTE")<br>    service_tags     = optional(list(string))<br>    subnet_id        = optional(string)<br>    subnet_cidr      = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connector_id"></a> [connector\_id](#output\_connector\_id) | ID of connector |
| <a name="output_implicit_group_id"></a> [implicit\_group\_id](#output\_implicit\_group\_id) | ID of implicit group automatically created with connector |
<!-- END_TF_DOCS -->