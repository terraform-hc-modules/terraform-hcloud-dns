variable "create" {
  description = "Whether to create the records."
  type        = bool
  default     = true
}

variable "zone" {
  description = "Zone ID or name."
  type        = string
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
