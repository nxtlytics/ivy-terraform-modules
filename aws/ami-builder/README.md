# About `ami-builder`

## Overview

This role is to be assigned to ec2 instances used to build AMIs

## Policies attached to this role:

- `arn:aws:iam::aws:policy/AWSOrganizationsReadOnlyAccess`
  - To parent account

## How was this setup?

### 1. Create ami-builder role in your [tools account](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#component-definitions)

```
cd /path/to/this/account/iam_roles/ami-builder
terragrunt apply --target=aws_iam_role.this
```

### 2. Create [orgs-readonly](../orgs-readonly) role in main account

```
cd /path/to/parent/account/iam_roles/tools-orgs-readonly/
terragrunt apply
```

### 3. Create instance profile and policy to allow it access to role in main account

```
cd /path/to/this/account/iam_roles/ami-builder
terragrunt apply
```

## Reference

- [Allowing an Instance Profile Role to Switch to a Role in Another Account](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html#switch-role-ec2-another-account)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | 2.67.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_identity\_partition | The partition that the resource is in ([ARN Syntax](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arns-syntax)). Examples: arn:aws, arn:aws-us-gov, arn:aws-cn | `string` | `"aws"` | no |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| parent\_account\_id | AWS Account ID of the parent organization | `string` | n/a | yes |
| parent\_account\_role\_name | Name of the role that allows access to the parent's account resources | `string` | n/a | yes |
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
