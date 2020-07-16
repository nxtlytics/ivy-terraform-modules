variable "namespace" {
  type        = string
  description = "Prefix to use with all tag keys"
}

variable "sysenv" {
  type        = string
  description = "See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md)"
}

variable "environment" {
  type        = string
  description = "See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name)"
}

variable "team_email" {
  type        = string
  description = "E-Mail for the team managing these resources"
}

variable "tags" {
  type        = map
  description = "A mapping of tags to assign to the resources in this module."
  default     = {}
}

variable "region" {
  type        = string
  description = "AWS Region to use"
}

variable "profile" {
  type        = string
  description = "~/.aws/credentials profile to use with the terraform aws provider not the s3 backend"
}

variable "aws_identity_partition" {
  type        = string
  description = "The partition that the resource is in ([ARN Syntax](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arns-syntax)). Examples: arn:aws, arn:aws-us-gov, arn:aws-cn"
  default     = "aws"
}

variable "child_account_id" {
  type        = string
  description = "AWS Account ID of the child organization"
}

variable "child_account_role_name" {
  type        = string
  description = "Name of the role that allows child account access to the parent's account resources"
}
