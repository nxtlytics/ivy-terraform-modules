# Create a storage account in Azure

[Storage Account Overview](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview?toc=/azure/storage/blobs/toc.json)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | =2.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account\_replication\_type | Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS` and `ZRS`. | `string` | n/a | yes |
| account\_tier | Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`. For `FileStorage` accounts only `Premium` is valid. Changing this forces a new resource to be created. | `string` | n/a | yes |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| name | Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only. | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| resource\_group\_name | Resource Group to use for these resources. [What is a Resource Group?](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagmentGroupsAndHierarchy) | `string` | n/a | yes |
| sysenv | See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md) | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resources in this module. | `map` | `{}` | no |
| team\_email | E-Mail for the team managing these resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| azurerm\_storage\_account-this-id | ID for this storage account |
| azurerm\_storage\_account-this-identity | An `identity` block as defined below, which contains the Identity information for this Storage Account. |
| azurerm\_storage\_account-this-primary\_location | The primary location of the storage account. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
