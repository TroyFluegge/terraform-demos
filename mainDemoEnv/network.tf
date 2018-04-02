module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "azcMainVPC"
  cidr = "192.168.0.0/16"

  azs            = ["us-east-2a"]
  public_subnets = ["192.168.2.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Environment = "Prod"
    Owner       = "Adam"
  }
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "azcMainSecurityGroup"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    Owner = "Adam"
  }
}