variable "region" {
  type        = string
  description = "Region to create AWS Resources"
}

variable "project" {
  type        = string
  description = "Project Name"
}

variable "vpc-cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "az-suffix" {
  type        = list(string)
  description = "Availability Zone suffixes"
}

variable "public-cidr" {
  type        = list(string)
  description = "CIDR blocks for PUBLIC subnets"
}

variable "private-cidr" {
  type        = list(string)
  description = "CIDR blocks for PRIVATE subnets"
}

variable "allow-ingress-cidr" {
  type        = list(string)
  description = "Allow Public CIDR blocks"
}

variable "allow-egress-cidr" {
  type        = string
  description = "Allow egress Public CIDR blocks"
}
