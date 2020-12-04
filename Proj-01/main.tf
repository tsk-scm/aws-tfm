module "vpc" {
  source   = "../modules/vpc"
  vpc-cidr = "192.168.1.0/24"
  vpc-name = "vpc1"

}

module "public-subnet" {
  source       = "../modules/subnet"
  vpc-id       = module.vpc.vpc-id
  vpc-name     = "vpc1"
  az           = ["us-east-1a", "us-east-1b"]
  sn-cidr      = ["192.168.1.0/27", "192.168.1.32/27"]
  sn-intent    = "Public"
  ip-on-launch = true

}

module "private-subnet" {
  source       = "../modules/subnet"
  vpc-id       = module.vpc.vpc-id
  vpc-name     = "vpc1"
  az           = ["us-east-1a", "us-east-1b"]
  sn-cidr      = ["192.168.1.64/27", "192.168.1.96/27"]
  sn-intent    = "Private"
  ip-on-launch = false

}

