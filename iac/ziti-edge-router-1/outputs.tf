output "ziti-edge-router-1-eip" {
  value       = aws_eip.ziti_edge_router_1_eip.public_ip
  description = "Ziti Edge Router 1 EIP"
} 