output "ziti-controller-eip" {
  value       = aws_eip.ziti_controller_eip.public_ip
  description = "Ziti Controller EIP"
}