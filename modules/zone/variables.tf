variable "create" {
  description = "Whether to create the zone."
  type        = bool
  default     = true
}

variable "name" {
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
