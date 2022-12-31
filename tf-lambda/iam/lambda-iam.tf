provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "lambda_code_bucket" {
  bucket = "lambdacodebucket"
  acl    = "private"
}

resource "aws_s3_bucket_object" "lambda_code" {
  bucket = "lambdacodebucket"
  key    = "lambda_function.zip"
  source = "./lambda_function.zip"
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "lambda_function.zip"
  function_name    = "lambda_function"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_function.handler"
  runtime          = "python3.8"

  environment {
    variables = {
      MY_VARIABLE = "my_value"
    }
  }

  s3_bucket = "lambdacodebucket"
  s3_key    = "lambda_function.zip"
}