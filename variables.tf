variable "create_zone" {
  type    = bool
  default = true
}

variable "zone_name" {
  type = string
}

variable "ttl" {
  type    = number
  default = 3600
}

variable "records" {
  type = list(object({
    name  = string
    type  = string
    value = string
    ttl   = optional(number)
  }))
  default = []
}
