## VPC Variables
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

## Security Group Variables

# EC2 Instance variables

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


variable "sg_ingress_rules" {
  description = "Ingress security group rules"
  type        = map(any)
}

variable "sg-name" {
  type        = string
  description = "Security Group Suffix"
}

variable "sg-description" {
  type = string
  description = "Security Group Description"
}