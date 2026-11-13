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

output "records" {
  description = "Map of managed records, keyed by a stable unique key. Each value has zone, name, type, value and comment."
  value       = module.records.records
}

output "records_by_type_name" {
  description = "Map of record values grouped by record type and name, keyed as '<TYPE>-<NAME>'."
  value       = module.records.records_by_type_name
}

output "rrset_ids" {
  description = "Map of created RRSet IDs, keyed as '<TYPE>-<NAME>'."
  value       = module.rrsets.rrset_ids
}
