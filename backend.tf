terraform {
  backend "s3" {
    bucket         = "tacbotinc-s3-statefile"
    key            = "backend/terraform.state"
    region         = "us-east-1"
    # acl            = "bucket-owner-full-control"
    dynamodb_table = "tacbotinc-dynamodb-statefile"
  }
}