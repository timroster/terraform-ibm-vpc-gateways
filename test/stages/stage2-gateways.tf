module "gateways" {
  source = "./module"

  resource_group_id = module.resource_group.id
  region            = var.region
  vpc_name          = module.vpc.name
  enabled           = var.enabled
}

resource null_resource print_enabled {
  provisioner "local-exec" {
    command = "echo -n '${var.enabled}' > .enabled"
  }
}
