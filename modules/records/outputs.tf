output "record_ids" {
  description = "Map of record IDs."
  value       = { for k, v in hcloud_zone_record.this : k => v.id }
}
