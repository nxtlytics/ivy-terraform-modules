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

variable "domain" {
  type        = string
  description = "DNS domain zone"
}

variable "description" {
  description = "Description of the DNS Zone"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "vpc id to associate this private zone to, by default is empty which creates a public zone"
  default     = ""
}

variable "alias" {
  type        = any
  description = "List of DNS Aliases to add to the DNS zone"
  default = {
    names    = []
    types    = []
    values   = []
    zones_id = []
  }
}

variable "non_alias" {
  type        = any
  description = "List of DNS Records to add to the DNS zone"
  default = {
    names  = []
    types  = []
    ttls   = []
    values = []
  }
}
