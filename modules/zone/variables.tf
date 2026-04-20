variable "create" {
  description = "Whether to create the zone."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the zone (domain)."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "The 'name' must not be empty."
  }
}

variable "mode" {
  description = "Mode of the zone (primary or secondary)."
  type        = string
  default     = "primary"

  validation {
    condition     = contains(["primary", "secondary"], lower(var.mode))
    error_message = "The 'mode' must be one of: primary, secondary."
  }
}

variable "ttl" {
  description = "Default TTL in seconds."
  type        = number
  default     = 3600

  validation {
    condition     = var.ttl >= 60 && var.ttl <= 86400
    error_message = "The 'ttl' must be between 60 and 86400 seconds."
  }
}

variable "labels" {
  description = "Labels to apply."
  type        = map(string)
  default     = {}
}

variable "delete_protection" {
  description = "Enable delete protection."
  type        = bool
  default     = false
}
