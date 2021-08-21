locals {
  resource_prefix = "${lower(replace(var.project, " ", ""))}-${var.stage}-webfarm"

  default_tags = {
    Project = var.project
    Stage   = var.stage
  }
}
