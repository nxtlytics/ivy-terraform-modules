# About ACM Certificates module

- Creates a wildcard certificate for domain

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | 2.44.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| domain\_name | A domain name for which the certificate should be issued | `string` | n/a | yes |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| profile | ~/.aws/credentials profile to use with the terraform aws provider not the s3 backend | `string` | n/a | yes |
| region | AWS Region to use | `string` | n/a | yes |
| subject\_alternative\_names | A list of domains that should be SANs in the issued certificate | `list` | `[]` | no |
| sysenv | See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md) | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resources in this module. | `map` | `{}` | no |
| team\_email | E-Mail for the team managing these resources | `string` | n/a | yes |
| validation\_method | Which method to use for validation. `DNS` or `EMAIL` are valid, `NONE` can be used for certificates that were imported into ACM and then into Terraform. | `string` | `"DNS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_acm\_certificate-this-arn | Amazon Resource Name for this ACM Certificate |
| aws\_acm\_certificate-this-domain\_name | The domain name for which the certificate is issued |
| aws\_acm\_certificate-this-domain\_validation\_options | ID for this IAM user policy, in the form of `user_name:user_policy_name` |
| aws\_acm\_certificate-this-unique\_id | Unique ID for this ACM Certificate |
| aws\_acm\_certificate\_policy-this-validation\_emails | A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
