resource "hcloud_zone" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  mode                = var.mode
  ttl                 = var.ttl
  labels              = var.labels
  delete_protection   = var.delete_protection
  primary_nameservers = var.primary_nameservers // Added primary_nameservers argument
}
