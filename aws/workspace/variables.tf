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

variable "remote_state_bucket" {
  type        = string
  description = "The name of the S3 bucket where the terraform state is stored"
}

variable "remote_state_key" {
  type        = string
  description = "The path to the state file inside the bucket"
}

variable "profile" {
  type        = string
  description = "~/.aws/credentials profile to use with the terraform aws provider not the s3 backend"
}

variable "bundle_name" {
  type        = string
  description = "The name of the bundle"
  default     = "Value with Windows 10"
}

variable "bundles" {
  type        = map
  description = "Map of Bundle Name and Bundle ID"
  default = {
    "Performance with Windows 7" : "wsb-b0s22j3d7",
    "Standard with Amazon Linux 2" : "wsb-clj85qzj1",
    "Performance with Windows 10" : "wsb-gm4d5tx2v",
    "PowerPro with Windows 7" : "wsb-1pzkp0bx4",
    "Power with Amazon Linux 2" : "wsb-2bs6k5lgn",
    "Performance with Windows 10 and Office 2016" : "wsb-6cdbk8901",
    "Value with Windows 10" : "wsb-bh8rsxt14",
    "Value with Windows 7" : "wsb-92tn3b7gx",
    "Standard with Windows 10 and Office 2016" : "wsb-dfyzk6mz7",
    "Graphics with Windows 7 and Office 2010" : "wsb-wwx8kkwg5",
    "Standard with Windows 7" : "wsb-3t36q0xfc",
    "Performance with Amazon Linux 2" : "wsb-j4dky1gs4",
    "Standard with Windows 10 and Office 2016" : "wsb-9jvhtb24f",
    "Performance with Windows 10 and Office 2016" : "wsb-05t16yhz8",
    "Graphics with Windows 7 and Office 2013" : "wsb-44r73z5dr",
    "Performance with Windows 7 and Office 2010" : "wsb-1b5w6vnz6",
    "Standard with Windows 10" : "wsb-362t3gdrt",
    "PowerPro with Windows 10 and Office 2016" : "wsb-ddkxkghsv",
    "PowerPro with Windows 10" : "wsb-f5g1109b5",
    "Value with Windows 10" : "wsb-4qyzfv08r",
    "Value with Amazon Linux 2" : "wsb-8pmj7b7pq",
    "Value with Windows 7 and Office 2013" : "wsb-fgy4lgypc",
    "Performance with Windows 7 and Office 2013" : "wsb-vbsjd64y6",
    "Graphics with Windows 10" : "wsb-320p8vd2j",
    "PowerPro with Windows 10" : "wsb-g0xb96cdv",
    "Value with Windows 7 and Office 2010" : "wsb-kgjp98lt8",
    "GraphicsPro with Windows 10" : "wsb-g6cjhl60w",
    "Graphics with Windows 10 and Office 2016" : "wsb-ftkjdlgks",
    "Power with Windows 10 and Office 2016" : "wsb-hztzqyk3m",
    "GraphicsPro with Windows 10 and Office 2016" : "wsb-5rlx0zrt5",
    "PowerPro with Windows 10 and Office 2016" : "wsb-j1ckzg142",
    "Power with Windows 10" : "wsb-drh4m5c2r",
    "PowerPro with Windows 7 and Office 2013" : "wsb-0h0yf5w9q",
    "Power with Windows 7" : "wsb-cq3wxw02g",
    "Power with Windows 7 and Office 2013" : "wsb-2gcd1nm07",
    "Standard with Windows 10" : "wsb-8vbljg4r6",
    "Power with Windows 10" : "wsb-w42vs8svd",
    "PowerPro with Amazon Linux 2" : "wsb-b1h39vgz8",
    "Graphics with Windows 7" : "wsb-dy4bd5kvl",
    "Value with Windows 10 and Office 2016" : "wsb-df76rqys9",
    "Power with Windows 10 and Office 2016" : "wsb-64nqp4sgx",
    "Standard with Windows 7 and Office 2013" : "wsb-5h1pf1zxc",
    "Standard with Windows 7 and Office 2010" : "wsb-vlsvncjjf",
    "Performance with Windows 10" : "wsb-b9jc2fhhl",
    "Value with Windows 10 and Office 2016" : "wsb-0zsvgp8fc"
  }
}

variable "username" {
  type        = string
  description = "The user name of the user for the WorkSpace"
}

variable "email" {
  type        = string
  description = "The email of the user for the WorkSpace"
}

variable "root_volume_encryption_enabled" {
  type        = bool
  description = "Indicates whether the data stored on the root volume is encrypted"
  default     = true
}

variable "user_volume_encryption_enabled" {
  type        = bool
  description = "Indicates whether the data stored on the user volume is encrypted"
  default     = true
}

variable "volume_encryption_key" {
  type        = string
  description = "The symmetric AWS KMS customer master key (CMK) used to encrypt data stored on your WorkSpace. Amazon WorkSpaces does not support asymmetric CMKs"
  default     = ""
}

variable "compute_type_name" {
  type        = string
  description = "The compute type. For more information, see [Amazon WorkSpaces Bundles](http://aws.amazon.com/workspaces/details/#Amazon_WorkSpaces_Bundles). Valid values are `VALUE`, `STANDARD`, `PERFORMANCE`, `POWER`, `GRAPHICS`, `POWERPRO` and `GRAPHICSPRO`"
  default     = "Value"
}

variable "user_volume_size_gib" {
  type        = number
  description = "The size of the user storage"
  default     = 10
}

variable "root_volume_size_gib" {
  type        = number
  description = "The size of the root volume"
  default     = 80
}

variable "running_mode" {
  type        = string
  description = "The running mode. For more information, see [Manage the WorkSpace Running Mode](https://docs.aws.amazon.com/workspaces/latest/adminguide/running-mode.html). Valid values are `AUTO_STOP` and `ALWAYS_ON`"
  default     = "AUTO_STOP"
}

variable "running_mode_auto_stop_timeout_in_minutes" {
  type        = number
  description = "The time after a user logs off when WorkSpaces are automatically stopped. Configured in 60-minute intervals"
  default     = 60
}
