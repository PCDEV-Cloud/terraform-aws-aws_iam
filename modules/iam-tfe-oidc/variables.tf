variable "identity_provider_url" {
  type        = string
  default     = "https://app.terraform.io"
  description = ""

  validation {
    condition     = startswith(var.identity_provider_url, "https://")
    error_message = "The identity_provider_url must begin with 'https://'."
  }
}

variable "audience" {
  type        = string
  default     = "aws.workload.identity"
  description = ""
}

variable "thumbprints" {
  type        = list(string)
  default     = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  description = ""
}

variable "access_configuration" {
  type = list(object({
    organization = string
    project      = optional(string, "Default")
    workspaces   = optional(list(string), ["*"])
    run_phase    = optional(string, "*")
  }))
  description = "description"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = ""
}