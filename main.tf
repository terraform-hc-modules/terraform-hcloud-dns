module "zone" {
  source = "./modules/zone"

  create            = var.create_zone
  name              = var.zone_name
  mode              = var.mode
  ttl               = var.ttl
  labels            = var.labels
  delete_protection = var.delete_protection
}

module "records" {
  source = "./modules/records"

  create  = var.create_zone && length(var.records) > 0
  zone_id = module.zone.id
  records = var.records
}
