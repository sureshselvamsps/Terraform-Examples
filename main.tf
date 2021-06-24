resource "vault_aws_secret_backend" "aws" {
  access_key = "AKIAXBTJUNSWPOQMOQ4X"
  secret_key = "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"
}

resource "vault_aws_secret_backend_role" "role" {
  backend = vault_aws_secret_backend.aws.path
  name    = "test"

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    }
  ]
}
EOT
}

# generally, these blocks would be in a different module
data "vault_aws_access_credentials" "creds" {
  backend = vault_aws_secret_backend.aws.path
  role    = vault_aws_secret_backend_role.role.name
}

provider "aws" {
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
  region = var.aws_region
}
resource "aws_instance" "insta" { 
    ami = "ami-0d5eff06f840b45e9"
    instance_type = "t2.micro"
    tags = {
    Name = "Terraform Cloud testing"
  }
}
