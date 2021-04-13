output "count" {
  description = "The number of gateways created"
  value       = local.gateway_count
}

output "ids" {
  description = "List of ids of gateways created"
  value       = ibm_is_public_gateway.vpc_gateway[*].id
}
