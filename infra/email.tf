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
