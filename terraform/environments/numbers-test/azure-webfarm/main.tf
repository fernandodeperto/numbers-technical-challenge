
module "webfarm" {
  source  = "../../../modules/azure-webfarm"
  project = "Numbers"
  stage   = "test"
  branch  = "0.5.0"
}

output "module" {
  sensitive = true
  value     = module.webfarm
}
