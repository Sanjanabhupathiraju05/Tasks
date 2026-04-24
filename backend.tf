terraform {
  backend "s3" {
    bucket = "tf-bucket-remote-statefile" # Nee bucket name
    key = "dev/terraform.tfstate" # S3 lo path
    region = "ap-south-1"
    encrypt = true # Security kosam
    # dynamodb_table = "terraform-lock" # (Optional) Future lo locking kosam
    dynamodb_table = "terraform-lock"
  }
}
