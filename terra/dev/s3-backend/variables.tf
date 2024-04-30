variable "terraform_account_id" {
  description = "Allowed AWS account id where resources can be created"
  type        = string
}

variable "region_s3_backend" {
  description = "Name of the region in which resources will be created"
  type        = string
}