data "cloudflare_zone" "mingjiaocf" {
  provider      = cloudflare.cloudflare
  zone_id       = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "dns_record_for_ziti_edge_router_1" {
  provider      = cloudflare.cloudflare
  zone_id       = data.cloudflare_zone.mingjiaocf.zone_id
  comment       = "Ziti Edge Router 1"
  content       = aws_eip.ziti_edge_router_1_eip.public_ip
  name          = "ziti-edge-router-1"
  proxied       = false
  ttl           = 60
  type          = "A"
}


resource "cloudflare_dns_record" "dns_record_for_ziti_service" {
  provider      = cloudflare.cloudflare
  zone_id       = data.cloudflare_zone.mingjiaocf.zone_id
  comment       = "Ziti Service"
  content       = aws_eip.ziti_edge_router_1_eip.public_ip
  name          = "ziti-service"
  proxied       = false
  ttl           = 60
  type          = "A"
}