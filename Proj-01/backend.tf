terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "tskprod-terraform"
    key            = "Proj-01/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform-state"
  }
}
