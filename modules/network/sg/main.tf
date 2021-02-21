resource "aws_security_group" "allow" {
  name        = "${var.project}-${var.sg-name}"
  vpc_id      = var.vpc_id
  description = "Allow all inbound traffic"
  tags = {
    Name = "${var.project}-${var.sg-name}"
  }
}

resource "aws_security_group_rule" "allow" {
  for_each = var.sg_ingress_rules

  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  security_group_id = aws_security_group.allow.id
}