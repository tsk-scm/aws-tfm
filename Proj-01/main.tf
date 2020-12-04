module "vpc" {
  source   = "../modules/vpc"
  vpc-cidr = "192.168.1.0/24"
  vpc-name = "vpc1"

}