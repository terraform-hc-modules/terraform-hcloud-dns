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
