data "template_file" "this" {
  template = file("${path.module}/custom_data.sh.tpl")

  vars = {
    commit              = var.commit
    flask_secret_key    = random_string.flask_secret_key.result
    postgresql_host     = azurerm_private_endpoint.this.private_service_connection.0.private_ip_address
    postgresql_username = "postgres@numbers-test-webfarm-postgres"
    postgresql_password = random_password.postgresql.result
  }
}

data "azurerm_dns_zone" "this" {
  name                = "apilabs.xyz"
  resource_group_name = "${lower(replace(var.project, " ", ""))}-prod-zone"
}
