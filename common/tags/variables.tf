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

variable "service" {
  type        = string
  description = "Service (e.g. `cassandra` or `kafka`)."
}

variable "service_namespace" {
  type        = string
  default     = ""
  description = "Service (e.g. `app` or `ingest`)."
}

variable "role" {
  type        = string
  default     = ""
  description = "If set it will override the value for the `namespace:role` tag"
}

variable "team_email" {
  type        = string
  description = "E-Mail for the team managing these resources"
}

variable "createdby" {
  type        = string
  default     = "terraform"
  description = "CreatedBy, eg 'terraform'."
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment` and `name`."
}
