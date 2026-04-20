variable "create" {
  type    = bool
  default = true
}

variable "name" {
  description = "Zone name (domain)."
  type        = string
}

variable "ttl" {
  description = "Default TTL in seconds."
  type        = number
  default     = 3600
}
