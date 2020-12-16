output "vpc-id" {
  value = aws_vpc.this.id
}
output "public-sn" {
  value = aws_subnet.public.*.id
}
output "public-ip" {
  value = aws_instance.this.*.public_ip
}
