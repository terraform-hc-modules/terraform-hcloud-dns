resource "hcloud_zone_rrset" "this" {
  for_each = var.create ? { for r in var.rrsets : format("%s-%s", upper(r.type), r.name) => r } : {}

  zone              = provider::hcloud::idna(var.zone)
  name              = each.value.name
  type              = each.value.type
  ttl               = each.value.ttl
  labels            = each.value.labels
  change_protection = each.value.change_protection
  # The DNS API expects TXT values as quoted strings of at most 255 characters.
  # Values that are already quoted are passed through unchanged.
  records = [for rec in each.value.records : merge(rec, {
    value = upper(each.value.type) == "TXT" && !startswith(rec.value, "\"") ? provider::hcloud::txt_record(rec.value) : rec.value
  })]
}
