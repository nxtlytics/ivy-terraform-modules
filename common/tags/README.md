# Tags generator

Inspired by [clouddrove/terraform-labels](https://github.com/clouddrove/terraform-labels)

This module helps create our base tags across resources, keep in mind it does not create the `Name` that lots of resources in AWS use, please be sure to created when needed.

## About tags in AWS

- [Using tags](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html)
  - [Tag Restrictions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-restrictions)
  - [Resources that support tagging](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-ec2-resources-table)

## About tags in Azure

- [Use tags with your Azure Resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources)
- [Azure Resources that support tags](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)

## About labels in GCP (tags equivalent)

- [Creating and Managing Labels](https://cloud.google.com/resource-manager/docs/creating-managing-labels)
  - [Services that support labels](https://cloud.google.com/resource-manager/docs/creating-managing-labels#label_support)
- [Labeling Resources](https://cloud.google.com/compute/docs/labeling-resources)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| null | ~> 2.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| createdby | CreatedBy, eg 'terraform'. | `string` | `"terraform"` | no |
| delimiter | Delimiter to be used between `namespace`, `environment` and `name`. | `string` | `"-"` | no |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| role | If set it will override the value for the `namespace:role` tag | `string` | `""` | no |
| service | Service (e.g. `cassandra` or `kafka`). | `string` | n/a | yes |
| service\_namespace | Service (e.g. `app` or `ingest`). | `string` | `""` | no |
| sysenv | See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md) | `string` | n/a | yes |
| team\_email | E-Mail for the team managing these resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| tags | Normalized Tag map. |
| tags\_asg\_format | Tags in the AWS AutoScaling Group format. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
