output "public-sn" {
  value = aws_subnet.public.*.id
}

output "public-sg" {
  value = aws_security_group.allow_ssh.id
}
