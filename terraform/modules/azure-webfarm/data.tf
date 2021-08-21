data "template_file" "this" {
  template = file("${path.module}/custom_data.sh.tpl")

  vars = {
    stage = var.stage
  }
}
