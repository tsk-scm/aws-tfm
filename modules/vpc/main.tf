resource "aws_vpc" "main" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc-name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc-name}-gw"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  count = length(var.az)
  cidr_block = var.sn-cidr[count.index]
  map_public_ip_on_launch = var.ip-on-launch
  availability_zone = var.az[count.index]

  tags = {
    Name = "${var.vpc-name}-${var.sn-intent}"
    Intent = var.sn-intent
  }
}