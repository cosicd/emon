# Development environment

This is development environment.

## Set AWS CLI

1. Download and install AWS CLI according to documentation. Check the version and path to both aws and aws_complete. According to link (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html) set up aws autocomplete.

2. Create IAM "terraform_user" and access key.

3. Create profile with command command aws configure. Check it with command:

```zsh
aws configure list
```
4. Set AWS_PROFILE environment variable to that profile if you have more profiles.
5. Check access to AWS account with below command:

```zsh
aws sts get-caller-identity
```

Output should be like below:

```zsh
 "UserId": "AIDAW3MD6MILPDC6GBG2V",
    "Account": "471112507926",
    "Arn": "arn:aws:iam::471112507926:user/terraform_user"
}
```

## Install terraform

Install terraform according to documentation on link (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) and check with below command:

```zsh
terraform -help
```


Enable autocomplete option with below command:

```zsh
terraform -install-autocomplete
```

## Create GIT repo for the project if it doesn't exist

Everything regarding the infrastructure that gets provisioned over terraform should be under folder "terra". The folder should look like below:

```zsh
.
└── emon
    ├── .git    
    ├── .gitignore
    ├── README.md
    └── terra
        ├── dev
        │   ├── README.md
        │   ├── main.tf
        │   ├── outputs.tf
        │   ├── terraform.tfvars
        │   ├── variables.tf
        │   └── vpc.tfo
        ├── modules
        │   └── vpc
        │       ├── main.tf
        │       ├── outputs.tf
        │       └── variables.tf
        └── prod
```

Create separate branch for all the changes that DevOps will introduce to repository with name "dops", and checkout that branch.
Create .gitignore file with below configuration or update existing one.

```zsh
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# Crash log files
crash.log
crash.*.log

# Exclude all .tfvars files, which are likely to contain sensitive data, such as
# password, private keys, and other secrets. These should not be part of version 
# control as they are data points which are potentially sensitive and subject 
# to change depending on the environment.
*.tfvars
*.tfvars.json

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Include override files you do wish to add to version control using negated pattern
# !example_override.tf

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
.terraformrc
terraform.rc
```


## Set terraform s3 backend with and DynamoDB lock record

In main.tf define S3 bucket and DynamoDB table for terraform lock. Setup terraform state backed to this s3 bucket and file terraform.state inside it.


### 1. Terraform S3 Backend
   Terraform’s S3 backend allows the state to be stored in an S3 bucket. Amazon S3 provides high availability and is an excellent choice for storing critical configuration data like Terraform state files. When combined with versioning, S3 also offers a way to view changes made to your infrastructure over time.

### 2. Use DynamoDB for Locking
   While S3 provides a reliable place to store state, it doesn’t natively provide a way to prevent two different Terraform operations from occurring simultaneously. Simultaneous operations could lead to conflicting changes, potentially corrupting the state.

## Create VPC 

Enter the folder "dev" and initialize the terraform. Check that s3 bucket, DynamoDB table for terraform lock and VPC is created.



# Reference documents
1. https://developer.hashicorp.com/terraform/language/settings/backends/s3
2. 