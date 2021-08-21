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

variable "branch" {
  description = "Name of the git branch or tag to be used on the deployment"
  default     = "technical-challenge"
}
