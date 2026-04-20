resource "hcloud_dns_zone" "this" {
  count = var.create ? 1 : 0

  name = var.name
  ttl  = var.ttl
}
