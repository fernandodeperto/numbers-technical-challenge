# output "tls_private_key" {
#   sensitive = true
#   value     = tls_private_key.this.private_key_pem
# }

output "postgres_password" {
  sensitive = true
  value     = random_password.postgresql.result
}
