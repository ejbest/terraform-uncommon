resource "cloudflare_dns_record" "tracker-db-root" {
  zone_id = local.cloudflare_zone_id
  name    = "@"
  value   = aws_eip.ejc-webserver-eip.public_ip
  type    = "A"
  ttl     = 3600
}
