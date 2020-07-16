# Route 53 Zone and records management

Inspired by [Aplyca/terraform-aws-route53](https://github.com/Aplyca/terraform-aws-route53)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | 2.67.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| alias | List of DNS Aliases to add to the DNS zone | `any` | <pre>{<br>  "names": [],<br>  "types": [],<br>  "values": [],<br>  "zones_id": []<br>}</pre> | no |
| description | Description of the DNS Zone | `string` | `""` | no |
| domain | DNS domain zone | `string` | n/a | yes |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| non\_alias | List of DNS Records to add to the DNS zone | `any` | <pre>{<br>  "names": [],<br>  "ttls": [],<br>  "types": [],<br>  "values": []<br>}</pre> | no |
| profile | ~/.aws/credentials profile to use with the terraform aws provider not the s3 backend | `string` | n/a | yes |
| region | AWS Region to use | `string` | n/a | yes |
| sysenv | See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md) | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resources in this module. | `map` | `{}` | no |
| team\_email | E-Mail for the team managing these resources | `string` | n/a | yes |
| vpc\_id | vpc id to associate this private zone to, by default is empty which creates a public zone | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_route53\_zone-this-name | The Hosted Zone Name. This can be referenced by zone records. |
| aws\_route53\_zone-this-name\_servers | A list of name servers in associated (or default) delegation set. |
| aws\_route53\_zone-this-zone\_id | The Hosted Zone ID. This can be referenced by zone records. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
