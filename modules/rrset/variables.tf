variable "create" {
  description = "Whether to create the RRSets."
  type        = bool
  default     = true
}

variable "zone" {
  description = "Zone ID or name."
  type        = string

  validation {
    condition     = length(trimspace(var.zone)) > 0
    error_message = "The 'zone' must not be empty."
  }
}

variable "rrsets" {
  description = "List of DNS RRSets. Each name and type pair must be unique, all values for that pair go in 'records'."
  type = list(object({
    name              = string
    type              = string
    ttl               = optional(number)
    labels            = optional(map(string))
    change_protection = optional(bool)
    records = list(object({
      value   = string
      comment = optional(string)
    }))
  }))
  default = []

  validation {
    condition = alltrue([
      for r in var.rrsets :
      length(trimspace(r.name)) > 0 && length(trimspace(r.type)) > 0 && length(r.records) > 0
    ])
    error_message = "Each RRSet must have non-empty 'name' and 'type' and at least one record."
  }
}
