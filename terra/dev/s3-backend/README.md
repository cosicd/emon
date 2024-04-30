# S3 backend for Terraform

Create a s3 bucket and dynamodb table to use as terraform backend.

* dynamodb_table_name = terraform-lock
* s3_bucket_name = <account_id>-terraform-states

# usage

```
# make sure you are on the right aws account for terraform user
aws sts get-caller-identity 
{
    "UserId": "AIDAW3MD6MILPDC6GBG2V",
    "Account": "471112507926",
    "Arn": "arn:aws:iam::471112507926:user/terraform_user"
}

# If you don't set default region in your aws configuration, and you want to create the resources in region "us-west-1"
export AWS_DEFAULT_REGION=us-west-1
export AWS_REGION=us-west-1

# Dry-run
terraform init
terraform plan -var-file="s3-backend.tfvars"

# apply the change
terraform apply terraform plan -var-file="s3-backend.tfvars"

# record the output of terraform apply like below

Outputs:

dynamodb_table_arn = "arn:aws:dynamodb:eu-west-1:471112507926:table/terraform-lock"
dynamodb_table_name = "terraform-lock"
s3_bucket_arn = "arn:aws:s3:::471112507926-terraform-states"
s3_bucket_name = "471112507926-terraform-states"
s3_bucket_region = "eu-west-1"

# 
```
