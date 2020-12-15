terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "tskprod-terraform"
    key            = "Proj-03/terraform.tfstate"
    dynamodb_table = "terraform-state"
    encrypt        = true
  }
}
