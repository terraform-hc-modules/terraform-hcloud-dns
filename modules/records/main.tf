resource "hcloud_zone_record" "this" {
  for_each = var.create ? { for idx, r in var.records : format("%s-%s-%03d", upper(r.type), r.name, idx) => r } : {}

  zone  = var.zone
  name  = each.value.name
  type  = each.value.type
  value = each.value.value
}
