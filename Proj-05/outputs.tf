output "public-sn" {
  value = module.vpc.public-sn
}

output "public-ips" {
  value = module.web
}

output "public-sg" {
  value = module.vpc.public-sg
}
