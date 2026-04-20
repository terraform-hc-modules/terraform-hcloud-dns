output "id" {
  value = try(hcloud_dns_zone.this[0].id, null)
}

output "name" {
  value = try(hcloud_dns_zone.this[0].name, null)
}
