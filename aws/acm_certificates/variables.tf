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

variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued"
}

variable "validation_method" {
  type        = string
  description = "Which method to use for validation. `DNS` or `EMAIL` are valid, `NONE` can be used for certificates that were imported into ACM and then into Terraform."
  default     = "DNS"
}

variable "subject_alternative_names" {
  type        = list
  description = "A list of domains that should be SANs in the issued certificate"
  default     = []
}
