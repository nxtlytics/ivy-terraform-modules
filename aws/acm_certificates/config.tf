# Configure the AWS Provider
provider "aws" {
  version = "2.44.0"
  region  = var.region
  profile = var.profile
}

# Intentionally empty. Will be filled by Terragrunt.
terraform {
  backend "s3" {}
}
