module "apigateway" {
  api_gateway_name = var.api_gateway_name
  source           = "./modules/apigateway"

  vpc_id              = module.vpc.vpc_id
  private_subnets_ids = module.vpc.private_subnets_ids
}
