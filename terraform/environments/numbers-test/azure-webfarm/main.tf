
module "webfarm" {
  source  = "../../../modules/azure-webfarm"
  project = "Numbers"
  stage   = "test"
  commit  = var.commit
}

output "module" {
  sensitive = true
  value     = module.webfarm
}
