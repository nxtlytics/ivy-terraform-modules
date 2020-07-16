# Create a storage container in Azure

[Azure Blob Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)

**Note:** cannot use tags as metadata `Error: MetaData must start with letters or an underscores. Got "ivy:service".`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | =2.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| container\_access\_type | The Access Level configured for this Container. Possible values are `blob`, `container` or `private`. Defaults to `private`. | `string` | `"private"` | no |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| name | The name of the Container which should be created within the Storage Account. | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| resource\_group\_name | Resource Group to use for these resources. [What is a Resource Group?](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagmentGroupsAndHierarchy) | `string` | n/a | yes |
| storage\_account\_name | Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only. | `string` | n/a | yes |
| sysenv | See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md) | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resources in this module. | `map` | `{}` | no |
| team\_email | E-Mail for the team managing these resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| azurerm\_storage\_container-this-has\_immutability\_policy | Is there an Immutability Policy configured on this Storage Container? |
| azurerm\_storage\_container-this-has\_legal\_hold | Is there a Legal Hold configured on this Storage Container? |
| azurerm\_storage\_container-this-id | ID for this storage account |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
