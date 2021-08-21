data "template_file" "this" {
  template = file("${path.module}/custom_data.sh.tpl")

  vars = {
    branch = var.branch
  }
}
