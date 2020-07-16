# S3 bucket for storing terraform state

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | 2.67.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| acl | The [canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) to apply | `string` | `"private"` | no |
| aws\_identity\_partition | The partition that the resource is in ([ARN Syntax](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arns-syntax)). Examples: arn:aws, arn:aws-us-gov, arn:aws-cn | `string` | `"aws"` | no |
| bucket\_name | Bucket Name | `string` | n/a | yes |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| principal\_org\_id | Principal Org ID, more at [link](https://aws.amazon.com/about-aws/whats-new/2018/05/principal-org-id/) | `string` | n/a | yes |
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
