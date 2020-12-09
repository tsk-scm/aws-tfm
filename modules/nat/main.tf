resource "aws_eip" "nat" {
  vpc      = true
  tags = {
    Name = var.nat-name
  }
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.subnet-id

  tags = {
    Name = var.nat-name
  }
}
