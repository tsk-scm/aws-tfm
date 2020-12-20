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
}
