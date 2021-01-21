module "vpc" {
  source          = "../modules/network/vpc/2tier"
  region          = var.region
  project         = var.project
  vpc-cidr        = var.vpc-cidr
  az-suffix       = var.az-suffix
  public-subnets  = var.public-subnets
  private-subnets = var.private-subnets
}

# module "web" {
#   source        = "../modules/compute/ec2"
#   count         = length(module.vpc.public-sn)
#   ami           = var.ami["amazon"]
#   instance-type = var.instance-type
#   instance-name = "${var.instance-name}${count.index}"
#   key-name      = var.key-name
#   subnet-id     = element(module.vpc.public-sn, count.index)
#   security_groups = [module.vpc.public-sg]
# }
