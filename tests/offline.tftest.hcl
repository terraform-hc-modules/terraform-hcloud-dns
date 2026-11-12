provider "hcloud" {
  token = "dummy"
}

run "zone_plan_offline" {
  command = plan

  plan_options {
    refresh = false
  }

  module {
    source = "./modules/zone"
  }

  variables {
    create = false
    name   = "example.com"
    mode   = "primary"
    ttl    = 3600
  }

  assert {
    condition     = output.id == null
    error_message = "expected no zone to be created"
  }
}

run "secondary_zone_with_tsig_plan_offline" {
  command = plan

  plan_options {
    refresh = false
  }

  module {
    source = "./modules/zone"
  }

  variables {
    name = "example.com"
    mode = "secondary"

    primary_nameservers = [
      { address = "203.0.113.10", port = 53, tsig_algorithm = "hmac-sha256", tsig_key = "c2VjcmV0" },
    ]
  }

  assert {
    condition     = length(hcloud_zone.this) == 1
    error_message = "expected a secondary zone to be planned"
  }
}

run "records_plan_offline" {
  command = plan

  plan_options {
    refresh = false
  }

  module {
    source = "./modules/records"
  }

  variables {
    create = false
    zone   = "example.com"

    records = [
      { name = "@", type = "A", value = "1.2.3.4" },
      { name = "@", type = "A", value = "1.2.3.5" },
      { name = "@", type = "A", value = "1.2.3.6" },
    ]
  }
}
