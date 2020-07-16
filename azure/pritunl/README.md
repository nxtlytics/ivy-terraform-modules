# Create pritunl instance in Azure

For more on user-data, custom data and cloud-init on Microsoft Azure go [here](https://azure.microsoft.com/en-gb/blog/custom-data-and-cloud-init-on-windows-azure/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | =2.2.0 |
| random | ~> 2.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| admin\_user | name of the admin user for this instance | `string` | n/a | yes |
| admin\_user\_public\_ssh\_key | public ssh key for the admin user | `string` | n/a | yes |
| client\_subnets | list of pritunl client subnets to add to route table | `list(string)` | n/a | yes |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| mongodb\_cidr | CIDR where Mongo DB lives | `string` | n/a | yes |
| mongodb\_endpoint | Mongo DB Endpoint to use. Like `mongodb://fqdn/pritunl` | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| pritunl\_uuid | Unique identifier for this pritunl server | `string` | n/a | yes |
| prompt\_color | Color to use for the shell prompt | `string` | n/a | yes |
| resource\_group\_name | Resource Group to use for these resources. [What is a Resource Group?](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagmentGroupsAndHierarchy) | `string` | n/a | yes |
| route\_table\_name | name of route table where client subnet(s) will be added | `string` | n/a | yes |
| subnet\_name | Azure subnet where the VM will be located at | `string` | n/a | yes |
| sysenv | See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md) | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resources in this module. | `map` | `{}` | no |
| team\_email | E-Mail for the team managing these resources | `string` | n/a | yes |
| virtual\_network\_name | Azure virtual network where the VM will be located at | `string` | n/a | yes |
| vpn\_supernet | CIDR all client\_subnets are a part of | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| azurerm\_linux\_virtual\_machine-this-fqdn | Fully Qualified Domain Name of this Virtual Machine |
| azurerm\_linux\_virtual\_machine-this-id | ID for this virtual machine |
| azurerm\_linux\_virtual\_machine-this-location | Location of this Virtual Machine |
| azurerm\_linux\_virtual\_machine-this-name | Computer Name of this Virtual Machine |
| azurerm\_linux\_virtual\_machine-this-private\_ipv4 | Private IPv4 of this Virtual Machine |
| azurerm\_linux\_virtual\_machine-this-public\_ipv4 | Public IPv4 of this Virtual Machine |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
