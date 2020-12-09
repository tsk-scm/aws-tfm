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

data "aws_subnet_ids" "public-sn" {
  depends_on = [module.public-subnet]
  vpc_id     = module.vpc.vpc-id
  filter {
    name   = "tag:Intent"
    values = ["Public"]
  }
}

module "nat-gw" {
  source    = "../modules/nat"
  for_each  = data.aws_subnet_ids.public-sn.ids
  nat-name  = "nat-gw"
  subnet-id = each.value

}

