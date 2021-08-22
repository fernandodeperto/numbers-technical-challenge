output "kube_config_raw" {
  sensitive = true
  value     = module.aks.kube_config_raw
}

output "module" {
  sensitive = true
  value     = module.aks
}
