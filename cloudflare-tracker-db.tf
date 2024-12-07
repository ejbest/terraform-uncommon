resource "cloudflare_record" "tracker-db-root" {
  zone_id = local.cloudflare_zone_id
  name    = "@"
  content = aws_eip.one.public_ip
  type    = "A"
  ttl     = 3600
}

# Zoho domain verification

resource "cloudflare_record" "tracker-db-txt-zoho" {
  zone_id = local.cloudflare_zone_id
  name    = "@"
  content = "zoho-verification=zb17498197.zmverify.zoho.com"
  type    = "TXT"
  ttl     = 3600
}

# Zoho records for email configuration

# MX Records
# https://mailadmin.zoho.com/cpanel/home.do#domains/tracker-db.com/emailConfig/mx

resource "cloudflare_record" "tracker-db-mx-zoho" {
  zone_id  = local.cloudflare_zone_id
  name     = "@"
  content  = "mx.zoho.com"
  type     = "MX"
  priority = "10"
}

resource "cloudflare_record" "tracker-db-mx2-zoho" {
  zone_id  = local.cloudflare_zone_id
  name     = "@"
  content  = "mx2.zoho.com"
  type     = "MX"
  priority = "20"
}

resource "cloudflare_record" "tracker-db-mx3-zoho" {
  zone_id  = local.cloudflare_zone_id
  name     = "@"
  content  = "mx3.zoho.com"
  type     = "MX"
  priority = "50"
}

# SPF Records 
# https://mailadmin.zoho.com/cpanel/home.do#domains/tracker-db.com/emailConfig/spf

resource "cloudflare_record" "tracker-db-spf-zoho" {
  zone_id = local.cloudflare_zone_id
  name    = "@"
  content = "v=spf1 include:zohomail.com ~all"
  type    = "TXT"
  ttl     = 3600
}

# DKIM Records
# https://mailadmin.zoho.com/cpanel/home.do#domains/tracker-db.com/emailConfig/dkim/dkim-listing

resource "cloudflare_record" "tracker-db-dkim-zoho" {
  zone_id = local.cloudflare_zone_id
  name    = "s1._domainkey"
  content = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCW08FwsjFwhUUdBD6AK9G9sJpWaWf+vOZcORto6sR0jH2X9RgcpJ0XHwQxuLy10DfcVCbNpxftN6IKQHo7wPE7yp8YAQM7KUo/lZVYA4zpzIeL3y0NZis6zWOQ9AGvuOKwXL6+pMy0LWvt7xbp3B+3/ptr8/bWVBC6BQ0lRbumcQIDAQAB"
  type    = "TXT"
  ttl     = 3600
}

# DMARC Records
# https://mailadmin.zoho.com/cpanel/home.do#domains/tracker-db.com/emailConfig/dmarc

resource "cloudflare_record" "tracker-db-dmarc-zoho" {
  zone_id = local.cloudflare_zone_id
  name    = "_dmarc"
  content = "v=DMARC1; p=quarantine; rua=mailto:ej@tracker-db.com; ruf=mailto:ej@tracker-db.com; sp=quarantine; adkim=r; aspf=r"
  type    = "TXT"
  ttl     = 3600
}
