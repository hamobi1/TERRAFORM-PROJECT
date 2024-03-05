module "vpc" {
  source = "/Users/muratnesiren14/TERRAFORM-PROJECT/vpc_module"
  region = local.region
  tags = local.tags
}

module "bastion" {
  source = "/Users/muratnesiren14/TERRAFORM-PROJECT/bastionhost_module"
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  vpc_id = module.vpc.vpc_id
}


