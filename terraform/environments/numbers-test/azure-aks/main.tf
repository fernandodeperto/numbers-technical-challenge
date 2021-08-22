
module "aks" {
  source  = "../../../modules/azure-aks"
  project = "Numbers"
  stage   = "test"
}

output "module" {
  sensitive = true
  value     = module.aks
}
