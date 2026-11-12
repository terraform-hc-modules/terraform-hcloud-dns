resource "hcloud_zone_record" "this" {
  for_each = var.create ? { for idx, r in var.records : format("%s-%s-%03d", upper(r.type), r.name, idx) => r } : {}

  zone = provider::hcloud::idna(var.zone)
  name = each.value.name
  type = each.value.type
  # The DNS API expects TXT values as quoted strings of at most 255 characters.
  # Values that are already quoted are passed through unchanged.
  value   = upper(each.value.type) == "TXT" && !startswith(each.value.value, "\"") ? provider::hcloud::txt_record(each.value.value) : each.value.value
  comment = each.value.comment
}
