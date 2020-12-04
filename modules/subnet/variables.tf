variable "vpc-name" {
    type = string
    description = "Name of VPC"
}
variable "vpc-id" {
    type = string
    description = "VPC Identifier"
}

variable "sn-cidr" {
    type = list(string)
    description = "Subnet CIDR Block"
}

variable "sn-intent" {
    type = string
    description = "Purpose of Subnet block"
}

variable "ip-on-launch" {
    type = bool
    default = false
    description = "Flag to issue Public IP for EC2 instances"
}

variable "az" {
    type = list(string)
    description = "List of Availability zones for VPC"
}
