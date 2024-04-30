module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.8.1"

  name = var.name
  cidr = var.cidr
  azs = var.azs

  public_subnets = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}