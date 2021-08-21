
module "webfarm" {
  source  = "../../../modules/azure-webfarm"
  project = "Numbers"
  stage   = "test"
}

output "module" {
  sensitive = true
  value     = module.webfarm
}
