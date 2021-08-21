locals {
  resource_prefix = "${lower(replace(var.project, " ", ""))}-${var.stage}-webfarm"

  postgres_dbs = toset([
    "magnusapi",
  ])

  default_tags = {
    Project = var.project
    Stage   = var.stage
  }
}
