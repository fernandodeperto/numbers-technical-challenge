
module "service_principal" {
  source  = "../../../modules/azure-service-principal"
  project = "Numbers"
  stage   = "test"
}

output "module" {
  value = module.service_principal
}
