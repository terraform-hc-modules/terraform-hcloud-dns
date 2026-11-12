output "rrset_ids" {
  description = "Map of RRSet IDs, keyed as '<TYPE>-<NAME>'."
  value       = { for k, v in hcloud_zone_rrset.this : k => v.id }
}
