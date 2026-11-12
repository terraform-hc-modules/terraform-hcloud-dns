module "zone" {
  source = "./modules/zone"

  create              = var.create_zone
  name                = var.zone_name
  mode                = var.mode
  ttl                 = var.ttl
  labels              = var.labels
  delete_protection   = var.delete_protection
  primary_nameservers = var.primary_nameservers
}

module "records" {
  source = "./modules/records"

  create = var.create_zone && length(var.records) > 0
  # Referencing the zone module orders record creation after the zone exists.
  zone    = coalesce(module.zone.name, var.zone_name)
  records = var.records
}

module "rrsets" {
  source = "./modules/rrset"

  create = var.create_zone && length(var.rrsets) > 0
  # Referencing the zone module orders RRSet creation after the zone exists.
  zone   = coalesce(module.zone.name, var.zone_name)
  rrsets = var.rrsets
}
