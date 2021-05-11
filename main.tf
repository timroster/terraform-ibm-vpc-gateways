
locals {
  zone_count     = 3
  vpc_zone_names = [ for index in range(var.subnet_count): "${var.region}-${(index % local.zone_count) + 1}" ]
  gateway_count  = min(local.zone_count, var.subnet_count)
  gateway_ids    = ibm_is_public_gateway.vpc_gateway[*].id
}

resource null_resource print_names {
  provisioner "local-exec" {
    command = "echo 'VPC name: ${var.vpc_name}'"
  }
}

data ibm_is_vpc vpc {
  depends_on = [null_resource.print_names]

  name = var.vpc_name
}

resource ibm_is_public_gateway vpc_gateway {
  count = local.gateway_count

  name           = "${var.vpc_name}-gw-${local.vpc_zone_names[count.index]}"
  vpc            = data.ibm_is_vpc.vpc.id
  zone           = local.vpc_zone_names[count.index]
  resource_group = var.resource_group_id

  //User can configure timeouts
  timeouts {
    create  = "15m"
    delete = "15m"
  }
}
