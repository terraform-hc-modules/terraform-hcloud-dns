resource "hcloud_zone" "this" {
  count = var.create ? 1 : 0

  name              = var.name
  mode              = var.mode
  ttl               = var.ttl
  labels            = var.labels
  delete_protection = var.delete_protection

  # The API forbids primary_nameservers on primary zones, so an empty list is
  # normalised to null rather than sent as a set-but-empty attribute.
  primary_nameservers = try(length(var.primary_nameservers), 0) > 0 ? var.primary_nameservers : null

  lifecycle {
    precondition {
      condition     = lower(var.mode) != "secondary" || try(length(var.primary_nameservers), 0) > 0
      error_message = "The 'primary_nameservers' must be set when 'mode' is secondary."
    }

    precondition {
      condition     = lower(var.mode) != "primary" || try(length(var.primary_nameservers), 0) == 0
      error_message = "The 'primary_nameservers' must be omitted when 'mode' is primary."
    }
  }
}
