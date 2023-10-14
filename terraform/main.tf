terraform {
  backend "s3" {
    bucket = "amazon-connect-753032b15c4c"
    key    = "terraform"
    region = "us-west-2"
  }
  required_providers {
    aws = {
      version = ">= 5.21.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

output "lambda_function_arn" {
  value = aws_lambda_function.lambda.arn
}

