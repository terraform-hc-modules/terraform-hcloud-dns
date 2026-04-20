variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "zone_id" {
  description = "The ID of an existing DNS zone"
  type        = string
}
