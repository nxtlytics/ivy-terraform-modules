# Private S3 bucket

## Notes:

- [AWS Elastic Load Balancing Account IDs (Includes govcloud and China)](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-access-logs.html#attach-bucket-policy)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | 2.67.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| acl | The [canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) to apply | `string` | `"private"` | no |
| bucket\_name | Bucket Name | `string` | n/a | yes |
| custom\_statement | Custom statement to add to the policy | `string` | `""` | no |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| profile | ~/.aws/credentials profile to use with the terraform aws provider not the s3 backend | `string` | n/a | yes |
| region | AWS Region to use | `string` | n/a | yes |
| sysenv | See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md) | `string` | n/a | yes |
| tags | A mapping of tags to assign to the bucket. | `map` | `{}` | no |
| team\_email | E-Mail for the team managing these resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_s3\_bucket-this-arn | The Amazon Resource Name (ARN) of this bucket |
| aws\_s3\_bucket-this-id | The name of this bucket |
| aws\_s3\_bucket-this-region | Region where this bucket is located |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
