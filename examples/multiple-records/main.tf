provider "hcloud" {}

locals {
  name = "ex-${basename(path.cwd)}"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-hcloud-dns"
    GithubOrg  = "terraform-hc-modules"
  }
}

################################################################################
# DNS Module - Zone with Multiple Record Types
################################################################################

module "dns" {
  source = "../../"

  zone_name = "example.com"
  mode      = "primary"
  ttl       = 3600
  labels    = local.tags

  records = [
    # A Records
    { name = "@", type = "A", value = "1.2.3.4" },
    { name = "www", type = "A", value = "1.2.3.4" },
    { name = "api", type = "A", value = "1.2.3.5" },

    # AAAA Records
    { name = "@", type = "AAAA", value = "2001:db8::1" },

    # CNAME Records
    { name = "blog", type = "CNAME", value = "www.example.com." },
    { name = "docs", type = "CNAME", value = "www.example.com." },

    # MX Records
    { name = "@", type = "MX", value = "10 mail.example.com." },
    { name = "@", type = "MX", value = "20 mail2.example.com." },

    # TXT Records
    { name = "@", type = "TXT", value = "v=spf1 include:_spf.google.com ~all" },
    { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=quarantine; rua=mailto:dmarc@example.com" },
  ]
}
