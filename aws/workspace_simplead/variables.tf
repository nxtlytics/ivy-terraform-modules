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

variable "ssm_parameter" {
  type        = string
  description = "The name of the parameter with the directory password"
}

variable "name" {
  type        = string
  description = "The fully qualified name for the directory, such as `corp.example.com`"
}

variable "size" {
  type        = string
  description = "The size of the directory (`Small` or `Large` are accepted values)"
}

variable "change_compute_type" {
  type        = bool
  description = "Whether WorkSpaces directory users can change the compute type (bundle) for their workspace"
  default     = false
}

variable "increase_volume_size" {
  type        = bool
  description = "Whether WorkSpaces directory users can increase the volume size of the drives on their workspace"
  default     = false
}

variable "rebuild_workspace" {
  type        = bool
  description = "Whether WorkSpaces directory users can rebuild the operating system of a workspace to its original state"
  default     = false
}

variable "restart_workspace" {
  type        = bool
  description = "Whether WorkSpaces directory users can restart their workspace"
  default     = true
}

variable "switch_running_mode" {
  type        = bool
  description = "Whether WorkSpaces directory users can switch the running mode of their workspace"
  default     = false
}
