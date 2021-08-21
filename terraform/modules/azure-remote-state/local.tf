locals {
  resource_prefix = "${lower(replace(var.project, " ", ""))}-${var.stage}-tfstate"

  default_tags = {
    Project = var.project
    Stage   = var.stage
  }
}
