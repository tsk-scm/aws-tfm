output "public-ips" {
  value = aws_instance.main.*.public_ip
}
