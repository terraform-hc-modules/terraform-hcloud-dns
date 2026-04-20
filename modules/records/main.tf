resource "hcloud_zone_record" "this" {
  for_each = var.create ? { for r in var.records : "${r.type}-${r.name}" => r } : {}

  zone  = var.zone
  name  = each.value.name
  type  = each.value.type
  value = each.value.value
}
