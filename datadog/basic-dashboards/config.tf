# Configure the Datadog Provider
# Set you API_KEY and APP_KEY in environment variables
# export DD_API_KEY='<KEY Here>'
# export DD_APP_KEY='<KEY Here>'
provider "datadog" {
  version = "2.11.0"
}

# Intentionally empty. Will be filled by Terragrunt.
terraform {
  backend "s3" {}
}
