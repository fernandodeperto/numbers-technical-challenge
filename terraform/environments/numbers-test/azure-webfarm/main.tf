
module "webfarm" {
  source  = "../../../modules/azure-webfarm"
  project = "Numbers"
  stage   = "test"
  branch  = var.branch
}

output "module" {
  sensitive = true
  value     = module.webfarm
}
