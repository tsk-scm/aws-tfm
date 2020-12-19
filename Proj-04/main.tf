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

resource "aws_subnet" "dmz" {
  count                   = length(var.dmz-sn)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.dmz-sn[count.index]
  availability_zone       = "${var.region}${var.azs[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-dmz-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "web" {
  count                   = length(var.web-sn)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.web-sn[count.index]
  availability_zone       = "${var.region}${var.azs[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-web-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "app" {
  count                   = length(var.app-sn)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.app-sn[count.index]
  availability_zone       = "${var.region}${var.azs[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-app-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "dbs" {
  count                   = length(var.dbs-sn)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.dbs-sn[count.index]
  availability_zone       = "${var.region}${var.azs[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-dbs-${var.azs[count.index]}"
  }
}

resource "aws_route_table" "dmz" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project}-dmz-rt"
  }
}

resource "aws_route_table" "web" {
  count  = length(var.web-sn)
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project}-web-rt-${var.azs[count.index]}"
  }
}

resource "aws_route_table" "app" {
  count  = length(var.dbs-sn)
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project}-app-rt-${var.azs[count.index]}"
  }
}

resource "aws_route_table" "dbs" {
  count  = length(var.dbs-sn)
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project}-dbs-rt-${var.azs[count.index]}"
  }
}

resource "aws_route_table_association" "dmz" {
  count          = length(var.dmz-sn)
  subnet_id      = element(aws_subnet.dmz.*.id, count.index)
  route_table_id = element(aws_route_table.dmz.*.id, count.index)
}

resource "aws_route_table_association" "web" {
  count          = length(var.web-sn)
  subnet_id      = element(aws_subnet.web.*.id, count.index)
  route_table_id = element(aws_route_table.web.*.id, count.index)
}

resource "aws_route_table_association" "app" {
  count          = length(var.app-sn)
  subnet_id      = element(aws_subnet.app.*.id, count.index)
  route_table_id = element(aws_route_table.app.*.id, count.index)
}

resource "aws_route_table_association" "dbs" {
  count          = length(var.dbs-sn)
  subnet_id      = element(aws_subnet.dbs.*.id, count.index)
  route_table_id = element(aws_route_table.dbs.*.id, count.index)
}

resource "aws_route" "i" {
  route_table_id         = aws_route_table.dmz.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
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

resource "aws_eip" "nat" {
  vpc   = true
  count = length(var.azs)
}

resource "aws_nat_gateway" "gw" {
  count         = length(var.azs)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.dmz.*.id, count.index)
  depends_on    = [aws_internet_gateway.this]
  tags = {
    Name = "${var.project}-nat-${var.azs[count.index]}"
  }

}
