# Create workspace

## Overview

This module create a username in a SimpleAD, retrieving the username's password from ssm and finally creates an AWS Workspace

## How user is created in `SimpleAD`

I'm creating a personal fork of a community created terraform provider for active directory, see [here](https://github.com/missingcharacter/terraform-provider-ad/tree/SimpleAD).

**Note:** Also, I made a [Pull Request](https://github.com/GSLabDev/terraform-provider-ad/pull/26) to give my changes back to the project.

### How to build active directory provider

```
$ mkdir -p "${GOPATH}/src/github.com/GSLabDev"
$ cd "${GOPATH}/src/github.com/GSLabDev"
$ git clone https://github.com/missingcharacter/terraform-provider-ad.git # Yes, you will not clone this to folder missingcharacter
$ cd terraform-provider-ad
$ go get gopkg.in/ldap.v3
$ go get github.com/hashicorp/terraform/terraform
$ go get github.com/hashicorp/terraform/plugin
$ go get github.com/hashicorp/terraform/helper/schema
$ make build
$ cp "${GOPATH}/bin/terraform-provider-ad" "$(which terraform | rev | cut -d '/' -f2- | rev)/"
```
Now you can start terraforming or terragrunting.

**Note:** I will try to provide pre-compiled binaries for Windows, MacOS and Linux.

## How bundles map was created

```
$ aws --profile=some-profile workspaces describe-workspace-bundles --owner AMAZON | jq --compact-output '.Bundles[] | {(.Name) : .BundleId}'
{"Performance with Windows 7":"wsb-b0s22j3d7"}
{"Standard with Amazon Linux 2":"wsb-clj85qzj1"}
{"Performance with Windows 10":"wsb-gm4d5tx2v"}
{"PowerPro with Windows 7":"wsb-1pzkp0bx4"}
{"Power with Amazon Linux 2":"wsb-2bs6k5lgn"}
{"Performance with Windows 10 and Office 2016":"wsb-6cdbk8901"}
{"Value with Windows 10":"wsb-bh8rsxt14"}
{"Value with Windows 7":"wsb-92tn3b7gx"}
{"Standard with Windows 10 and Office 2016":"wsb-dfyzk6mz7"}
{"Graphics with Windows 7 and Office 2010":"wsb-wwx8kkwg5"}
...
```

## How to `"manually"` check users

- Install ldapvi (`brew install ldapvi`)
- `ldapvi -h 10.20.143.123 -D 'cn=Administrator,cn=Users,dc=example,dc=org' -w '<Password>' -b 'cn=Users,dc=example,dc=org'`
  - Host IPs are the DNS addresses for the SimpleAD Directory

# Notes

## Terraform's support for workspaces

- See [github issue](https://github.com/terraform-providers/terraform-provider-aws/issues/434)
  - As of Jun 23, 2020 the issue is still open
  - Github issue was created in Jun 13, 2017


## Workaround

1. Create user

```shell
$ terragrunt apply -target=ad_user.this
```

2. Set the user password using the aws cli (I'll fix this issue in the AD terraform provider soon™️)

```shell
aws ds reset-user-password --directory-id <directory id in the terraform output> --user-name <username> --new-password <password in the terraform output>
```

3. Create workspace in AWS Console for the user you just created

4. Import the workspace to terraform

```shell
$ terragrunt import aws_workspaces_workspace.this ws-xxxxxxxxx
aws_workspaces_workspace.this: Importing from ID "ws-xxxxxxxxx"...
aws_workspaces_workspace.this: Import prepared!
  Prepared aws_workspaces_workspace for import
aws_workspaces_workspace.this: Refreshing state... [id=ws-xxxxxxxxx]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| ad | n/a |
| aws | 2.67.0 |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| bundle\_name | The name of the bundle | `string` | `"Value with Windows 10"` | no |
| bundles | Map of Bundle Name and Bundle ID | `map` | <pre>{<br>  "Graphics with Windows 10": "wsb-320p8vd2j",<br>  "Graphics with Windows 10 and Office 2016": "wsb-ftkjdlgks",<br>  "Graphics with Windows 7": "wsb-dy4bd5kvl",<br>  "Graphics with Windows 7 and Office 2010": "wsb-wwx8kkwg5",<br>  "Graphics with Windows 7 and Office 2013": "wsb-44r73z5dr",<br>  "GraphicsPro with Windows 10": "wsb-g6cjhl60w",<br>  "GraphicsPro with Windows 10 and Office 2016": "wsb-5rlx0zrt5",<br>  "Performance with Amazon Linux 2": "wsb-j4dky1gs4",<br>  "Performance with Windows 10": "wsb-b9jc2fhhl",<br>  "Performance with Windows 10 and Office 2016": "wsb-05t16yhz8",<br>  "Performance with Windows 7": "wsb-b0s22j3d7",<br>  "Performance with Windows 7 and Office 2010": "wsb-1b5w6vnz6",<br>  "Performance with Windows 7 and Office 2013": "wsb-vbsjd64y6",<br>  "Power with Amazon Linux 2": "wsb-2bs6k5lgn",<br>  "Power with Windows 10": "wsb-w42vs8svd",<br>  "Power with Windows 10 and Office 2016": "wsb-64nqp4sgx",<br>  "Power with Windows 7": "wsb-cq3wxw02g",<br>  "Power with Windows 7 and Office 2013": "wsb-2gcd1nm07",<br>  "PowerPro with Amazon Linux 2": "wsb-b1h39vgz8",<br>  "PowerPro with Windows 10": "wsb-g0xb96cdv",<br>  "PowerPro with Windows 10 and Office 2016": "wsb-j1ckzg142",<br>  "PowerPro with Windows 7": "wsb-1pzkp0bx4",<br>  "PowerPro with Windows 7 and Office 2013": "wsb-0h0yf5w9q",<br>  "Standard with Amazon Linux 2": "wsb-clj85qzj1",<br>  "Standard with Windows 10": "wsb-8vbljg4r6",<br>  "Standard with Windows 10 and Office 2016": "wsb-9jvhtb24f",<br>  "Standard with Windows 7": "wsb-3t36q0xfc",<br>  "Standard with Windows 7 and Office 2010": "wsb-vlsvncjjf",<br>  "Standard with Windows 7 and Office 2013": "wsb-5h1pf1zxc",<br>  "Value with Amazon Linux 2": "wsb-8pmj7b7pq",<br>  "Value with Windows 10": "wsb-4qyzfv08r",<br>  "Value with Windows 10 and Office 2016": "wsb-0zsvgp8fc",<br>  "Value with Windows 7": "wsb-92tn3b7gx",<br>  "Value with Windows 7 and Office 2010": "wsb-kgjp98lt8",<br>  "Value with Windows 7 and Office 2013": "wsb-fgy4lgypc"<br>}</pre> | no |
| compute\_type\_name | The compute type. For more information, see [Amazon WorkSpaces Bundles](http://aws.amazon.com/workspaces/details/#Amazon_WorkSpaces_Bundles). Valid values are `VALUE`, `STANDARD`, `PERFORMANCE`, `POWER`, `GRAPHICS`, `POWERPRO` and `GRAPHICSPRO` | `string` | `"Value"` | no |
| email | The email of the user for the WorkSpace | `string` | n/a | yes |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| profile | ~/.aws/credentials profile to use with the terraform aws provider not the s3 backend | `string` | n/a | yes |
| region | AWS Region to use | `string` | n/a | yes |
| remote\_state\_bucket | The name of the S3 bucket where the terraform state is stored | `string` | n/a | yes |
| remote\_state\_key | The path to the state file inside the bucket | `string` | n/a | yes |
| root\_volume\_encryption\_enabled | Indicates whether the data stored on the root volume is encrypted | `bool` | `true` | no |
| root\_volume\_size\_gib | The size of the root volume | `number` | `80` | no |
| running\_mode | The running mode. For more information, see [Manage the WorkSpace Running Mode](https://docs.aws.amazon.com/workspaces/latest/adminguide/running-mode.html). Valid values are `AUTO_STOP` and `ALWAYS_ON` | `string` | `"AUTO_STOP"` | no |
| running\_mode\_auto\_stop\_timeout\_in\_minutes | The time after a user logs off when WorkSpaces are automatically stopped. Configured in 60-minute intervals | `number` | `60` | no |
| sysenv | See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md) | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resources in this module. | `map` | `{}` | no |
| team\_email | E-Mail for the team managing these resources | `string` | n/a | yes |
| user\_volume\_encryption\_enabled | Indicates whether the data stored on the user volume is encrypted | `bool` | `true` | no |
| user\_volume\_size\_gib | The size of the user storage | `number` | `10` | no |
| username | The user name of the user for the WorkSpace | `string` | n/a | yes |
| volume\_encryption\_key | The symmetric AWS KMS customer master key (CMK) used to encrypt data stored on your WorkSpace. Amazon WorkSpaces does not support asymmetric CMKs | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| ad\_user-this-logon\_name | Active Directory Username for this workspace |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
