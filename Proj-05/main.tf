module "vpc" {
  source             = "../modules/network/vpc/2tier"
  region             = var.region
  project            = var.project
  vpc-cidr           = var.vpc-cidr
  az-suffix          = var.az-suffix
  public-cidr        = var.public-cidr
  private-cidr       = var.private-cidr
  allow-egress-cidr  = var.allow-egress-cidr
  allow-ingress-cidr = var.allow-ingress-cidr
  ssh-port           = var.ssh-port
}

module "web" {
  source                 = "../modules/compute/ec2"
  count                  = length(module.vpc.public-sn)
  ami                    = var.ami["amazon"]
  instance-type          = var.instance-type
  instance-name          = "${var.instance-name}${count.index}"
  key-name               = var.key-name
  subnet-id              = element(module.vpc.public-sn, count.index)
#  vpc-security-group-ids = module.vpc.public-ssh
}
