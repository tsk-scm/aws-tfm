resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.instance-type
  key_name      = var.key-name
  subnet_id     = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  tags = {
    Name = var.instance-name
  }
}
