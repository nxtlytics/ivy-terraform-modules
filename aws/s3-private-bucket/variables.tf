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

variable "region" {
  type        = string
  description = "AWS Region to use"
}

variable "profile" {
  type        = string
  description = "~/.aws/credentials profile to use with the terraform aws provider not the s3 backend"
}

variable "bucket_name" {
  type        = string
  description = "Bucket Name"
}

variable "acl" {
  type        = string
  description = "The [canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) to apply"
  default     = "private"
}

variable "tags" {
  type        = map
  description = "A mapping of tags to assign to the bucket."
  default     = {}
}

variable "custom_statement" {
  type        = string
  description = "Custom statement to add to the policy"
  default     = ""
}
