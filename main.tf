
locals {
  zone_count     = 3
  vpc_zone_names = [ for index in range(local.zone_count): "${var.region}-${(index % local.zone_count) + 1}" ]
  vpc_id         = length(data.ibm_is_vpc.vpc) > 0 ? data.ibm_is_vpc.vpc[0].id : ""
  gateway_count  = local.zone_count
  gateway_ids    = data.ibm_is_public_gateway.vpc_gateway[*].id
}

resource null_resource print_names {
  count = var.enabled ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'VPC name: ${var.vpc_name != null ? var.vpc_name : "null"}'"
  }
}

data ibm_is_vpc vpc {
  count = var.enabled ? 1 : 0
  depends_on = [null_resource.print_names]

  name = var.vpc_name
}

resource ibm_is_public_gateway vpc_gateway {
  count = var.provision && var.enabled ? local.gateway_count : 0

  name           = "${var.vpc_name}-gw-${local.vpc_zone_names[count.index]}"
  vpc            = local.vpc_id
  zone           = local.vpc_zone_names[count.index]
  resource_group = var.resource_group_id

  //User can configure timeouts
  timeouts {
    create  = "15m"
    delete = "15m"
  }
}

data ibm_is_public_gateway vpc_gateway {
  depends_on = [ibm_is_public_gateway.vpc_gateway]
  count = var.enabled ? local.gateway_count : 0

  name           = "${var.vpc_name}-gw-${local.vpc_zone_names[count.index]}"
  resource_group = var.resource_group_id
}
