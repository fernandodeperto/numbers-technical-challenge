
module "zone" {
  source  = "../../../modules/azure-zone"
  project = "Numbers"
  stage   = "prod"
}

output "module" {
  sensitive = true
  value     = module.zone
}
