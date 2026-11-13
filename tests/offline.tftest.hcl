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

run "records_txt_quoting_and_idna_plan_offline" {
  command = plan

  plan_options {
    refresh = false
  }

  module {
    source = "./modules/records"
  }

  variables {
    zone = "bücher.example"

    records = [
      { name = "@", type = "TXT", value = "v=spf1 -all" },
      { name = "_dmarc", type = "txt", value = "\"v=DMARC1; p=none\"" },
      { name = "@", type = "A", value = "1.2.3.4" },
    ]
  }

  assert {
    condition     = hcloud_zone_record.this["TXT-@-000"].value == "\"v=spf1 -all\""
    error_message = "expected an unquoted TXT value to be quoted"
  }

  assert {
    condition     = hcloud_zone_record.this["TXT-_dmarc-001"].value == "\"v=DMARC1; p=none\""
    error_message = "expected an already quoted TXT value to pass through unchanged"
  }

  assert {
    condition     = hcloud_zone_record.this["A-@-002"].value == "1.2.3.4"
    error_message = "expected non TXT values to pass through unchanged"
  }

  assert {
    condition     = hcloud_zone_record.this["A-@-002"].zone == "xn--bcher-kva.example"
    error_message = "expected the zone name to be converted to punycode"
  }
}

run "rrset_txt_quoting_plan_offline" {
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
        name    = "@"
        type    = "TXT"
        records = [{ value = "v=spf1 -all" }, { value = "\"already quoted\"" }]
      },
    ]
  }

  assert {
    condition     = toset([for r in hcloud_zone_rrset.this["TXT-@"].records : r.value]) == toset(["\"v=spf1 -all\"", "\"already quoted\""])
    error_message = "expected TXT values to be quoted exactly once"
  }
}
