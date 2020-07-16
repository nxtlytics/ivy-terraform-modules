# Configure the AWS Provider
provider "aws" {
  version = "2.67.0"
  region  = var.region
  profile = var.profile
}

data "terraform_remote_state" "ad" {
  backend = "s3"
  config = {
    bucket  = var.remote_state_bucket
    key     = var.remote_state_key
    region  = var.region
    profile = var.profile
  }
}

# Configure the Active Directory Provider
provider "ad" {
  domain   = data.terraform_remote_state.ad.outputs.aws_directory_service_directory-this-name
  user     = data.terraform_remote_state.ad.outputs.aws_directory_service_directory-this-username
  password = data.terraform_remote_state.ad.outputs.aws_directory_service_directory-this-password
  ip       = tolist(data.terraform_remote_state.ad.outputs.aws_directory_service_directory-this-dns_ip_addresses)[0]
}

# Intentionally empty. Will be filled by Terragrunt.
terraform {
  backend "s3" {}
}
