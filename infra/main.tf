# Configure Terraform 

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # backend "s3" {
  #   bucket = "dnx-challenge-terraform"
  #   key = "state.tfstate"
  #   region = "ap-southeast-2"
  # }

}

# Configure AWS Provider
# The provider section has no parameters because we’ve already provided the credentials needed to communicate with AWS API as environment variables in order have remote Terraform state 

provider "aws" {
  access_key = var.aws-access-key
  secret_key = var.aws-secret-key
  region     = var.aws_region
}