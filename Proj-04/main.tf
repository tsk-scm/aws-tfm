resource "aws_vpc" "this" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public-sn)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public-sn[count.index]
  availability_zone       = "${var.region}${var.azs[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-public-${var.azs[count.index]}"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route" "i" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

}

resource "aws_route_table_association" "a" {
  count          = length(var.public-sn)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_security_group" "public-tls" {
  name        = "public-tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.this.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group_rule" "public-tls" {
  count             = length(var.public-tls)
  type              = "ingress"
  from_port         = var.public-tls[count.index]
  to_port           = var.public-tls[count.index]
  protocol          = "tcp"
  cidr_blocks       = var.public-cidr
  security_group_id = aws_security_group.public-tls.id
}

resource "aws_instance" "this" {
  count                       = length(var.public-sn)
  ami                         = var.ami["amazon"]
  instance_type               = var.instance-type
  key_name                    = var.key-name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public-tls.id]
  subnet_id                   = aws_subnet.public[count.index].id
  tags = {
    Name        = var.project
    Description = "Managed by terraform"
  }
}
