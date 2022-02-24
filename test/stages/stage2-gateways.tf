module "gateways" {
  source = "./module"

  resource_group_id = module.resource_group.id
  region            = var.region
  vpc_name          = module.vpc.name
}
