variable "create" {
  type    = bool
  default = true
}

variable "zone_id" {
  description = "Zone ID to add records to."
  type        = string
}

variable "records" {
  description = "List of DNS records."
  type = list(object({
    name  = string
    type  = string
    value = string
    ttl   = optional(number)
  }))
  default = []
}
