data "cloudflare_zone" "mingjiaocf" {
  provider      = cloudflare.cloudflare
  zone_id       = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "dns_record_for_ziti_controller" {
  provider      = cloudflare.cloudflare
  zone_id       = data.cloudflare_zone.mingjiaocf.zone_id
  comment       = "Ziti Controller"
  content       = aws_eip.ziti_controller_eip.public_ip
  name          = "ziti-controller"
  proxied       = false
  ttl           = 60
  type          = "A"
}
