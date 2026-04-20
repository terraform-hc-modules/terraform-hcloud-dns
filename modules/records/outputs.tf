output "record_ids" {
  value = { for k, v in hcloud_dns_record.this : k => v.id }
}
