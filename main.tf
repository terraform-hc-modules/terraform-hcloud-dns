module "zone" {
  source = "./modules/zone"

  create = var.create_zone
  name   = var.zone_name
  ttl    = var.ttl
}

module "records" {
  source = "./modules/records"

  create  = var.create_zone && length(var.records) > 0
  zone_id = module.zone.id
  records = var.records
}
