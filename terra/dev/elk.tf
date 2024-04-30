data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# resource "aws_key_pair" "deployer" {
#   key_name   = "deployer-key"
#   public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFrtHTKyqADDH6HVNpvCISuYBY/UpdTCvU5I33DVDEth dusan.cosic@gmail.com"
# }

resource "aws_instance" "elk" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "m4.large"
  availability_zone = var.azs[0]
  security_groups = [aws_security_group.private_subnet.id]
  subnet_id = module.vpc.private_subnets[0]
  key_name = "deployer"

  root_block_device {
    volume_size = "15"
  }

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}