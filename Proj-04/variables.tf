variable "region" {
  type        = string
  description = "Region where AWS resources will be created"
}

variable "vpc-cidr" {
  type        = string
  description = "VPC CIDR Range"
}

variable "project" {
  type        = string
  description = "Name of the Project"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones to be used for the VPC"
}

variable "dmz-sn" {
  type        = list(string)
  description = "Public Subnets"
}

variable "web-sn" {
  type        = list(string)
  description = "Web Subnets"
}

variable "app-sn" {
  type        = list(string)
  description = "App Subnets"
}

variable "dbs-sn" {
  type        = list(string)
  description = "DB Subnets"
}

variable "public-tls" {
  type        = list(number)
  description = "Public Ports"
}

variable "public-cidr" {
  type        = list(string)
  description = "Public CIDR"
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
  description = "AWS Instance Type"
}

variable "key-name" {
  type        = string
  description = "AWS EC2 Instance SSH Key"
}

