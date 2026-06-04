variable "default_sso_user" {
  description = "Default IAM Identity Center user assigned to vended accounts. Override per account when required."
  type = object({
    email      = string
    first_name = string
    last_name  = string
  })
}

variable "default_tags" {
  description = "Default tags applied to every account request."
  type        = map(string)
  default     = {}
}

variable "accounts" {
  description = "Map of EBOS accounts to vend with AFT."
  type = map(object({
    email          = string
    name           = string
    ou             = string
    environment    = string
    application    = string
    customization  = string
    sso_user_email = optional(string)
    sso_first_name = optional(string)
    sso_last_name  = optional(string)
    tags           = optional(map(string), {})
    custom_fields  = optional(map(string), {})
  }))
}
