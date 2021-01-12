locals {
  vpc-name = "${var.project}-vpc"
}
resource "aws_vpc" "main" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = local.vpc-name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.vpc-name}-gw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.az-suffix)
  cidr_block              = var.public-cidr[count.index]
  availability_zone       = "${var.region}${var.az-suffix[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.vpc-name}-public"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.az-suffix)
  cidr_block              = var.private-cidr[count.index]
  availability_zone       = "${var.region}${var.az-suffix[count.index]}"
  map_public_ip_on_launch = false
  tags = {
    Name = "${local.vpc-name}-private"
  }
}

resource "aws_eip" "nat" {
  count = length(var.az-suffix)
  vpc   = true
  tags = {
    Name = "${local.vpc-name}-nat-${var.az-suffix[count.index]}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.az-suffix)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = "${local.vpc-name}-nat-${var.az-suffix[count.index]}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.vpc-name}-public-rt"
  }
}

resource "aws_route_table" "private" {
  count  = length(var.az-suffix)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.vpc-name}-private-rt-${var.az-suffix[count.index]}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.az-suffix)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.az-suffix)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = var.allow-egress-cidr
  gateway_id             = aws_internet_gateway.gw.id
  timeouts {
    create = "10m"
    delete = "10m"
  }
}

resource "aws_route" "private" {
  count                  = length(var.az-suffix)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = var.allow-egress-cidr
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
  timeouts {
    create = "10m"
    delete = "10m"
  }
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH ingress for Bastian"
    from_port   = var.ssh-port
    to_port     = var.ssh-port
    protocol    = "tcp"
    cidr_blocks = var.allow-ingress-cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
