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
    zone = "example.com"

    records = [
      { name = "@", type = "A", value = "1.2.3.4" },
      { name = "@", type = "A", value = "1.2.3.5" },
      { name = "@", type = "A", value = "1.2.3.6" },
    ]
  }

  assert {
    condition     = length(hcloud_zone_record.this) == 3
    error_message = "expected one record per value"
  }

  assert {
    condition     = output.records_by_type_name["A-@"] == ["1.2.3.4", "1.2.3.5", "1.2.3.6"]
    error_message = "expected record values grouped under 'A-@'"
  }
}

run "rrset_plan_offline" {
  command = plan

  plan_options {
    refresh = false
  }

  module {
    source = "./modules/rrset"
  }

  variables {
    zone = "example.com"

    rrsets = [
      {
        name = "@"
        type = "A"
        ttl  = 300
        records = [
          { value = "1.2.3.4" },
          { value = "1.2.3.5", comment = "secondary" },
        ]
      },
      {
        name    = "www"
        type    = "cname"
        records = [{ value = "example.com." }]
      },
    ]
  }

  assert {
    condition     = toset(keys(hcloud_zone_rrset.this)) == toset(["A-@", "CNAME-www"])
    error_message = "expected one RRSet per name and type, keyed as '<TYPE>-<NAME>'"
  }

  assert {
    condition     = length(hcloud_zone_rrset.this["A-@"].records) == 2
    error_message = "expected both A values in a single RRSet"
  }
}

run "rrset_empty_record_list_fails" {
  command = plan

  module {
    source = "./modules/rrset"
  }

  variables {
    zone   = "example.com"
    rrsets = [{ name = "@", type = "A", records = [] }]
  }

  expect_failures = [var.rrsets]
}

run "root_rrsets_plan_offline" {
  command = plan

  plan_options {
    refresh = false
  }

  variables {
    zone_name = "example.com"

    rrsets = [
      { name = "@", type = "A", records = [{ value = "1.2.3.4" }] },
    ]
  }

  assert {
    condition     = length(module.rrsets.rrset_ids) == 1
    error_message = "expected the root module to plan one RRSet"
  }
}
