output "public-sn" {
  value = aws_subnet.public.*.id
}
