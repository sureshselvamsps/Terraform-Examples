provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.aws_region
}
resource "aws_instance" "insta" { 
    ami = "ami-0d5eff06f840b45e9"
    instance_type = "t2.micro"
    tags = {
    Name = "Terraform Cloud testing"
  }
}
