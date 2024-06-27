# variable "aws_access_key" {
#   description = "aws user's access key"
# }

# variable "aws_secret_key" {
#   description = "aws user's secret key"
# }

variable "bucket_name" {
    type = string
    description = "bucket name"
}
variable "dynamo_db_name" {
    type = string
    description = "dynamo DB name"
}
variable "region_s3_dy" {
    type = string
    description = "region name"
}