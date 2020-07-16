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

variable "resource_group_name" {
  type        = string
  description = "Resource Group to use for these resources. [What is a Resource Group?](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagmentGroupsAndHierarchy)"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only."
}

variable "name" {
  type        = string
  description = "The name of the Container which should be created within the Storage Account."
}

variable "container_access_type" {
  type        = string
  description = "The Access Level configured for this Container. Possible values are `blob`, `container` or `private`. Defaults to `private`."
  default     = "private"
}

variable "tags" {
  type        = map
  description = "A mapping of tags to assign to the resources in this module."
  default     = {}
}
