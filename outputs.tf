output "zone_id" {
  description = "ID of the zone."
  value       = module.zone.id
}

output "zone_name" {
  description = "Name of the zone."
  value       = module.zone.name
}

output "authoritative_nameservers" {
  description = "Authoritative nameservers for the zone."
  value       = module.zone.authoritative_nameservers
}

output "record_ids" {
  description = "Map of created record IDs, keyed by a stable unique key."
  value       = module.records.record_ids
}

output "record_ids_by_type_name" {
  description = "Map of record IDs grouped by record type and name, keyed as '<TYPE>-<NAME>'."
  value       = module.records.record_ids_by_type_name
}
