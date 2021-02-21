variable "sg_ingress_rules" {
  description = "Ingress security group rules"
  type        = map(any)
}

variable "project" {
  type        = string
  description = "Project Name"
}

variable "sg-name" {
  type        = string
  description = "Security Group Suffix"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "sg-description" {
  type        = string
  description = "Security Group Description"
}