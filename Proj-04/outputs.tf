output "vpc-id" {
  value = aws_vpc.this.id
}
output "dmz-sn" {
  value = aws_subnet.dmz.*.id
}
