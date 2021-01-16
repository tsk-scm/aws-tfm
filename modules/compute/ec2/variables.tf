variable "ami" {
  type        = string
  description = "AMI for EC2 instance"
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

variable "subnet-id" {
  type        = string
  description = "EC2 Instance Subnet ID"
}

variable "vpc-security-group-ids" {
  type        = list(string)
  description = "List of Security groups"
}
