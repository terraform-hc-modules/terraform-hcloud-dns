module "wrapper" {
  source   = "../"
  for_each = var.items

  zone_name = each.value.zone_name
  ttl       = try(each.value.ttl, 3600)
  records   = try(each.value.records, [])
}

variable "items" {
  type    = any
  default = {}
}

output "wrapper" {
  value = module.wrapper
}
