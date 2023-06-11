provider "aws" {
  alias  = "aws"
  region = "us-east-1"

  shared-credentials_file = "~/.aws/credentials"
  profile                 = "default"

}