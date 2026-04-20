provider "hcloud" {
  token = var.hcloud_token
}

module "dns_records" {
  source = "../../modules/records"

  zone_id = var.zone_id

  records = {
    www = {
      name  = "www"
      type  = "A"
      value = "1.2.3.4"
      ttl   = 300
    }
    api = {
      name  = "api"
      type  = "A"
      value = "1.2.3.5"
      ttl   = 300
    }
  }

  rrsets = {
    ns = {
      name = "@"
      type = "NS"
      values = [
        "ns1.example.com.",
        "ns2.example.com.",
        "ns3.example.com."
      ]
    }
  }
}

output "records" {
  description = "Created DNS records"
  value       = module.dns_records.records
}

output "record_ids" {
  description = "List of record IDs"
  value       = module.dns_records.record_ids
}
