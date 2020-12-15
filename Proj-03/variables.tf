variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami" {
  type = map(string)
  default = {
    "amazon"  = "ami-04d29b6f966df1537",
    "ubuntu"  = "ami-00ddb0e5626798373",
    "win2016" = "ami-0081abcf0bf328e32"
  }
}
