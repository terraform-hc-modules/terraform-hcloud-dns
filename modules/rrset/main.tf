resource "hcloud_zone_rrset" "this" {
  for_each = var.create ? { for r in var.rrsets : format("%s-%s", upper(r.type), r.name) => r } : {}

  zone              = var.zone
  name              = each.value.name
  type              = each.value.type
  ttl               = each.value.ttl
  labels            = each.value.labels
  change_protection = each.value.change_protection
  records           = each.value.records
}
