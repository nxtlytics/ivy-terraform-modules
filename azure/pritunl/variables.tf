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

variable "virtual_network_name" {
  type        = string
  description = "Azure virtual network where the VM will be located at"
}

variable "subnet_name" {
  type        = string
  description = "Azure subnet where the VM will be located at"
}

variable "vpn_supernet" {
  type        = string
  description = "CIDR all client_subnets are a part of"
}

variable "client_subnets" {
  type        = list(string)
  description = "list of pritunl client subnets to add to route table"
}

variable "route_table_name" {
  type        = string
  description = "name of route table where client subnet(s) will be added"
}

variable "admin_user" {
  type        = string
  description = "name of the admin user for this instance"
}

variable "admin_user_public_ssh_key" {
  type        = string
  description = "public ssh key for the admin user"
}

variable "pritunl_uuid" {
  type        = string
  description = "Unique identifier for this pritunl server"
}

variable "mongodb_cidr" {
  type        = string
  description = "CIDR where Mongo DB lives"
}

variable "mongodb_endpoint" {
  type        = string
  description = "Mongo DB Endpoint to use. Like `mongodb://fqdn/pritunl`"
}

variable "prompt_color" {
  type        = string
  description = "Color to use for the shell prompt"
}

variable "tags" {
  type        = map
  description = "A mapping of tags to assign to the resources in this module."
  default     = {}
}
