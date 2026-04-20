output "id" {
  description = "ID of the zone."
  value       = try(hcloud_zone.this[0].id, null)
}

output "name" {
  description = "Name of the zone."
  value       = try(hcloud_zone.this[0].name, null)
}

output "authoritative_nameservers" {
  description = "Authoritative nameservers."
  value       = try(hcloud_zone.this[0].authoritative_nameservers, null)
}
