data "template_file" "this" {
  template = file("${path.module}/cloud-init.tpl.yaml")

  vars = {
    stage = var.stage
  }
}
