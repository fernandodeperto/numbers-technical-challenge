
module "remote_state" {
  source  = "../../../modules/azure-remote-state"
  project = "Numbers"
  stage   = "test"
}

output "module" {
  value = module.remote_state
}
