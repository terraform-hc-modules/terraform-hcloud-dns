# hcloud_zone_record has no id attribute (a record is identified by zone,
# name, type and value), so the outputs expose the records themselves.
output "records" {
  description = "Map of managed records, keyed by a stable unique key. Each value has zone, name, type, value and comment."
  value = {
    for k, v in hcloud_zone_record.this : k => {
      zone    = v.zone
      name    = v.name
      type    = v.type
      value   = v.value
      comment = v.comment
    }
  }
}

output "records_by_type_name" {
  description = "Map of record values grouped by record type and name, keyed as '<TYPE>-<NAME>'."
  value = {
    for key in distinct([for r in var.records : format("%s-%s", upper(r.type), r.name)]) :
    key => [
      for k, v in hcloud_zone_record.this :
      v.value if startswith(k, "${key}-")
    ]
  }
}
