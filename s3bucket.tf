# Create a bucket
resource "aws_s3_bucket" "b1" {
  bucket = "odd-terraform-bucket-test"
}

resource "aws_s3_bucket_ownership_controls" "b1" {
  bucket = aws_s3_bucket.b1.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "b1" {
  bucket = aws_s3_bucket.b1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "b1" {
  depends_on = [
    aws_s3_bucket_ownership_controls.b1,
    aws_s3_bucket_public_access_block.b1,
  ]

  bucket = aws_s3_bucket.b1.id
  acl    = "private"
}

# Upload an object
resource "aws_s3_object" "cv" {

  bucket = aws_s3_bucket.b1.id

  key    = "CV"

  acl    = "public-read"

  source = "/home/user/Downloads/odd-cv-2023.pdf"

}
