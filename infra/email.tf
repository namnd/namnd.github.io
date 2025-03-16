resource "aws_ses_domain_identity" "this" {
  domain = local.domain
}

# Verification
resource "aws_route53_record" "amazonses_verification_record" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.this.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.this.verification_token]
}

# DKIM
resource "aws_ses_domain_dkim" "this" {
  domain = aws_ses_domain_identity.this.domain
}

resource "aws_route53_record" "ses_dkim_records" {
  for_each = toset(aws_ses_domain_dkim.this.dkim_tokens)

  zone_id = aws_route53_zone.this.zone_id
  name    = "${each.value}._domainkey.${aws_ses_domain_identity.this.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${each.value}.dkim.amazonses.com"]
}

# DMARC
resource "aws_route53_record" "dmarc_record" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "_dmarc.namnd.com"
  type    = "TXT"
  ttl     = "600"
  records = ["v=DMARC1; p=none;"]
}

# MX
resource "aws_route53_record" "ses_mx_record" {
  zone_id = aws_route53_zone.this.zone_id
  name    = aws_ses_domain_identity.this.domain
  type    = "MX"
  ttl     = "600"
  records = ["10 inbound-smtp.${data.aws_region.current.name}.amazonaws.com"]
}

resource "aws_ses_receipt_rule_set" "this" {
  rule_set_name = "namnd.com"
}

resource "aws_ses_active_receipt_rule_set" "this" {
  rule_set_name = aws_ses_receipt_rule_set.this.id
}

resource "aws_s3_bucket" "email_storage" {
  bucket = "namnd-email-storage"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "email_storage" {
  bucket = aws_s3_bucket.email_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "ses_policy" {
  bucket = aws_s3_bucket.email_storage.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ses.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::namnd-email-storage/*"
        Condition = {
          StringEquals = {
            "aws:Referer" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "ses_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ses_role" {
  name               = "ses-role"
  assume_role_policy = data.aws_iam_policy_document.ses_assume_role_policy.json
}

data "aws_iam_policy_document" "ses_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.email_storage.bucket}/*"]
  }
}

resource "aws_iam_policy" "ses_policy" {
  name   = "ses-policy"
  policy = data.aws_iam_policy_document.ses_policy.json
}

resource "aws_iam_role_policy_attachment" "ses_policy_attachment" {
  role       = aws_iam_role.ses_role.name
  policy_arn = aws_iam_policy.ses_policy.arn
}

resource "aws_ses_receipt_rule" "store_emails" {
  name          = "me-namnd"
  rule_set_name = aws_ses_receipt_rule_set.this.id
  recipients    = ["me@namnd.com"]
  enabled       = true
  scan_enabled  = true

  s3_action {
    bucket_name       = aws_s3_bucket.email_storage.bucket
    position          = 1
    iam_role_arn      = aws_iam_role.ses_role.arn
    object_key_prefix = "me"
  }
}
