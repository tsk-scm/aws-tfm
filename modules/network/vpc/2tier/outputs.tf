output "public-sn" {
  value = aws_subnet.public.*.id
}

output "public-ssh" {
  value = aws_security_group.allow_ssh.id
}
