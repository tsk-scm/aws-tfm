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

variable "ssh-port" {
  type        = number
  description = "SSH port"
}

variable "allow-egress-cidr" {
  type        = string
  description = "Allow egress Public CIDR blocks"
}

variable "ami" {
  type = map(string)
  default = {
    "amazon"  = "ami-04d29b6f966df1537",
    "ubuntu"  = "ami-00ddb0e5626798373",
    "win2016" = "ami-0081abcf0bf328e32"
  }
}

variable "instance-type" {
  type        = string
  description = "EC2 instance type"
}

variable "instance-name" {
  type        = string
  description = "EC2 instance name"
}

variable "key-name" {
  type        = string
  description = "SSH Key name"
}

#variable "vpc-security-group-ids" {
#  type        = list(string)
#  description = "List of security groups"
#}
