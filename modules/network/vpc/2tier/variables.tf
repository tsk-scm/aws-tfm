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

variable "public-subnets" {
  type        = list(string)
  description = "CIDR blocks for PUBLIC subnets"
}

variable "private-subnets" {
  type        = list(string)
  description = "CIDR blocks for PRIVATE subnets"
}

