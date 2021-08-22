variable "project" {
  description = "Project name"
  type        = string
}

variable "stage" {
  description = "Stage name. Use one of (test|prod)"

  validation {
    condition     = contains(["test", "prod"], var.stage)
    error_message = "Stage must be one of (test|prod)."
  }
}

variable "location" {
  description = "Azure location code"
  default     = "westeurope"
}

variable "commit" {
  description = "Commit SHA that will be deployed"
}
