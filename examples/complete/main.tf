provider "hcloud" {}

module "dns" {
  source = "../../"

  zone_name = "example.com"

  records = [
    { name = "@", type = "A", value = "1.2.3.4" },
    { name = "www", type = "CNAME", value = "example.com." },
    { name = "mail", type = "MX", value = "10 mail.example.com." },
  ]
}
