##################################
# S3 service
#################################

resource "aws_s3_bucket" "website" {
  bucket = "keithportfoliowebsite"

  # Do not include versioning or any other deprecated settings here
}

# Disable versioning on the bucket using the aws_s3_bucket_versioning resource
resource "aws_s3_bucket_versioning" "website" {
  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status = "Suspended"  # Suspended disables versioning
  }
}

# Configure S3 bucket as a static website
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  # Optional: Add routing rules for the website
}

# Configure CORS for the bucket
resource "aws_s3_bucket_cors_configuration" "website" {
  bucket = aws_s3_bucket.website.bucket

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

# Attach bucket policy to allow CloudFront OAI access
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }

  depends_on = [
    aws_cloudfront_origin_access_identity.origin_access_identity
  ]
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_policy.json

  depends_on = [
    data.aws_iam_policy_document.s3_policy
  ]
}

# Configure Block Public Access settings (separate resource)
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls   = false
  block_public_policy = false
}

output "bucket_name" {
  value = aws_s3_bucket.website.id
}
