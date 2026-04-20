variable "create_zone" {
  description = "Whether to create the zone."
  type        = bool
  default     = true
}

variable "zone_name" {
  description = "Name of the zone (domain)."
  type        = string

  validation {
    condition     = length(trimspace(var.zone_name)) > 0
    error_message = "The 'zone_name' must not be empty."
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

variable "records" {
  description = "List of DNS records."
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = []

  validation {
    condition = alltrue([
      for r in var.records :
      length(trimspace(r.name)) > 0 && length(trimspace(r.type)) > 0 && length(trimspace(r.value)) > 0
    ])
    error_message = "Each record must have non-empty 'name', 'type', and 'value'."
  }
}
