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
# DNS Module - SPF / DMARC / DKIM (TXT)
################################################################################

module "dns" {
  source = "../../"

  zone_name = "example.com"
  mode      = "primary"
  ttl       = 3600
  labels    = local.tags

  records = [
    # SPF
    { name = "@", type = "TXT", value = "v=spf1 include:_spf.google.com ~all" },

    # DMARC
    { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=quarantine; rua=mailto:dmarc@example.com; ruf=mailto:dmarc@example.com" },

    # DKIM (example selector)
    { name = "google._domainkey", type = "TXT", value = "v=DKIM1; k=rsa; p=REPLACE_WITH_PUBLIC_KEY" },
  ]
}
