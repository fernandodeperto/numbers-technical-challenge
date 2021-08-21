locals {
  resource_prefix = "${lower(replace(var.project, " ", ""))}-${var.stage}-auth"

  default_tags = {
    Project = var.project
    Stage   = var.stage
  }
}
