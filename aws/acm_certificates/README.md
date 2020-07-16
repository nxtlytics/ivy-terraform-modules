# About ACM Certificates module

- Creates a wildcard certificate for domain

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
