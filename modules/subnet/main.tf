
resource "aws_subnet" "main" {
  vpc_id     = var.vpc-id
  count = length(var.az)
  cidr_block = var.sn-cidr[count.index]
  map_public_ip_on_launch = var.ip-on-launch
  availability_zone = var.az[count.index]

  tags = {
    Name = "${var.vpc-name}-${var.sn-intent}"
    Intent = var.sn-intent
  }
}