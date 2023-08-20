variable "identity_provider_url" {
  type        = string
  description = "The URL of the identity provider."

  validation {
    condition     = startswith(var.identity_provider_url, "https://")
    error_message = "The identity_provider_url must begin with 'https://'."
  }
}

variable "audience" {
  type        = string
  description = "The identity provider's client ID."
}

variable "thumbprints" {
  type        = list(string)
  default     = ["a031c46782e6e6c662c2c87c76da9aa62ccabd8e"]
  description = "A list of server certificate thumbprints for the identity provider's server certificate."
}

variable "repositories" {
  type = list(object(
    {
      name                            = string
      uuid                            = string
      environment_names               = optional(list(string), [])
      environment_uuids               = optional(list(string), [])
      iam_role_additional_policy_arns = optional(list(string), [])
    }
  ))
  default     = []
  description = "A list of objects that define the name and UUID of the repository and optionally environments."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of resource tags for the identity provider and IAM roles."
}