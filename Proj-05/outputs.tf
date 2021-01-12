output "public-sn" {
  value = module.vpc.public-sn
}

output "public-ips" {
  value = module.web
}

output "public-ssh" {
  value = module.vpc.public-ssh
}
