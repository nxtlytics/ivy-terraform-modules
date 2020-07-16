# About `workspaces_DefaultRole`

## Overview

Required role to create `AWS WorkSpaces Service` See [aws cli on register-workspace-directory](https://docs.aws.amazon.com/cli/latest/reference/workspaces/register-workspace-directory.html)

> This operation is asynchronous and returns before the WorkSpace directory is registered.
> If this is the first time you are registering a directory,
> you will need to create the `workspaces_DefaultRole` role before you can register a directory.
> For more information, see [Creating the workspaces_DefaultRole Role](https://docs.aws.amazon.com/workspaces/latest/adminguide/workspaces-access-control.html#create-default-role).

## Policies attached to this role:

- AWS Managed Policy `arn:aws:iam::aws:policy/AmazonWorkSpacesServiceAccess`
- AWS Managed Policy `arn:aws:iam::aws:policy/AmazonWorkSpacesSelfServiceAccess`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | 2.67.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| profile | ~/.aws/credentials profile to use with the terraform aws provider not the s3 backend | `string` | n/a | yes |
| region | AWS Region to use | `string` | n/a | yes |
| sysenv | See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md) | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resources in this module. | `map` | `{}` | no |
| team\_email | E-Mail for the team managing these resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_iam\_role-this-arn | Amazon Resource Name for this IAM role |
| aws\_iam\_role-this-name | Name for this IAM role |
| aws\_iam\_role-this-unique\_id | Unique ID for this IAM role |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
