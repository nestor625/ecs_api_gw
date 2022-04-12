
resource "aws_s3_bucket" "storage" {
  bucket = "${var.tag_proj}-${var.tag_env}-bucket"
}


locals {
  s3_origin_id = "${var.tag_proj}-${var.tag_env}-bucket"
}


resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.storage.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "storage" {
  bucket = aws_s3_bucket.storage.id
  policy = data.aws_iam_policy_document.storage.json
}

data "aws_iam_policy_document" "storage" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.s3.id }"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.storage.arn}/*"
    ]
  }
}


resource "aws_s3_bucket_public_access_block" "mybucket" {
  bucket = aws_s3_bucket.storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
