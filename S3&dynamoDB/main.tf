provider "aws" {
  region = var.region_s3_dy             #replace with Region
}

resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "${var.bucket_name}"
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "${var.bucket_name}"
  }
}

# resource "aws_s3_object" "backend" {
#   bucket = aws_s3_bucket.tfstate_bucket
#   key = "backend/"
#   acl = "private"
# }

resource "aws_dynamodb_table" "remote_state_table" {
  name = var.dynamo_db_name
  hash_key = "LockID" 
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  } 
  tags = {
    Name = var.dynamo_db_name
  }
}

