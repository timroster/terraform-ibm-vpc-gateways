output "count" {
  description = "The number of gateways created"
  value       = local.gateway_count
}

output "gateway_ids" {
  value       = local.gateway_ids
  description = "List of ids of the gateways created"
}

output "gateways" {
  description = "List of ids and zones of gateways created"
  value       = [ for id in local.gateway_ids: {id = id, zone = element(local.vpc_zone_names, index(local.gateway_ids, id))} ]
}
