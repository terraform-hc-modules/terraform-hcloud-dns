output "record_ids" {
  description = "Map of record IDs, keyed by a stable unique key."
  value       = { for k, v in hcloud_zone_record.this : k => v.id }
}

output "record_ids_by_type_name" {
  description = "Map of record IDs grouped by record type and name, keyed as '<TYPE>-<NAME>'."
  value = {
    for key in distinct([for r in var.records : format("%s-%s", upper(r.type), r.name)]) :
    key => [
      for k, v in hcloud_zone_record.this :
      v.id if startswith(k, "${key}-")
    ]
  }
}
