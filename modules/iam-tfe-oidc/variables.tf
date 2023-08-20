variable "identity_provider_url" {
  type        = string
  default     = "https://app.terraform.io"
  description = "The URL of the identity provider."

  validation {
    condition     = startswith(var.identity_provider_url, "https://")
    error_message = "The identity_provider_url must begin with 'https://'."
  }
}

variable "audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "The identity provider's client ID."
}

variable "thumbprints" {
  type        = list(string)
  default     = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  description = "A list of server certificate thumbprints for the identity provider's server certificate."
}

variable "access_configuration" {
  type = list(object({
    organization = string
    project      = optional(string, "Default")
    workspaces   = optional(list(string), ["*"])
    run_phase    = optional(string, "*")
  }))
  description = "A list of objects in which access to the AWS account is defined. Each object creates a separate IAM role. The organization, project, workspaces and run phase to which access is to be granted must be defined."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of resource tags for the identity provider and IAM roles."
}