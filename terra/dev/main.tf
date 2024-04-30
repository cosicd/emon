# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE AN S3 BUCKET AND DYNAMODB TABLE TO USE AS A TERRAFORM BACKEND
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# This module is forked from https://github.com/gruntwork-io/intro-to-terraform/tree/master/s3-backend
# ----------------------------------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12"

  # This backend configuration instructs Terraform to store its state in an S3 bucket.
  # Variables for backend are taken from output of terrafrom apply in s3-backend folder
  backend "s3" {
    allowed_account_ids = ["471112507926"] # List of allowed AWS account IDs to prevent potential destruction of a live environment.
    bucket         = "471112507926-terraform-states"  # Name of the S3 bucket where the state will be stored.
    key            = "terraform.state" # Path within the bucket where the state will be read/written.
    region         = "eu-west-1" # AWS region of the S3 bucket.
    dynamodb_table = "terraform-lock" # DynamoDB table used for state locking.
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
  }
}

# ------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ------------------------------------------------------------------------------
provider "aws" {
  region = var.region
}
