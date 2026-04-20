variable "create" {
  description = "Whether to create the records."
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
