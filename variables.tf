variable "create_zone" {
  description = "Whether to create the zone."
  type        = bool
  default     = true
}

variable "zone_name" {
  description = "Name of the zone (domain)."
  type        = string
}

variable "mode" {
  description = "Mode of the zone (primary or secondary)."
  type        = string
  default     = "primary"
}

variable "ttl" {
  description = "Default TTL in seconds."
  type        = number
  default     = 3600
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
}
