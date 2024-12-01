resource "cloudflare_record" "tracker-db-root" {
  zone_id = local.cloudflare_zone_id
  name    = "@"
  value   = aws_eip.ejb-webserver-eip.public_ip
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "tracker-db-txt-zoho" {
  zone_id = local.cloudflare_zone_id
  name    = "@"
  value   = "zoho-verification=zb17498197.zmverify.zoho.com"
  type    = "TXT"
  ttl     = 3600
}
