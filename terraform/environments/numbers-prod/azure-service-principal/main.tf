
module "service_principal" {
  source  = "../../../modules/azure-service-principal"
  project = "Numbers"
  stage   = "prod"
}

output "module" {
  sensitive = true
  value     = module.service_principal
}
