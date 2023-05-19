provider "aws" {
  alias  = "aws"
  region = "us-east-1"

  shared-credentials_file = "C:/Users/Francisco/.aws/credentials"
  profile                 = "default"

}