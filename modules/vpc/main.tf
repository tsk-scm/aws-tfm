resource "aws_vpc" "main" {
  cidr_block       = var.vpc-cidr
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
