provider "aws" {
  region              = "ap-southeast-2"
  allowed_account_ids = ["976193250022"]
}

resource "aws_route53_zone" "this" {
  name = "namnd.com"
}

resource "aws_route53_record" "gh_pages_txt" {
  name    = "_github-pages-challenge-namnd"
  zone_id = aws_route53_zone.this.zone_id
  type    = "TXT"
  ttl     = 60
  records = [
    "b08ca3c4f5fcbf0adbeb0aaad5eef4"
  ]
}
