/*
Alkira data sources
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs
*/
data "alkira_billing_tag" "tag" {
  for_each = toset(var.billing_tags)
  name     = each.key
}

data "alkira_credential" "credential" {
  name = var.credential
}

data "alkira_group" "group" {
  name = var.group
}

data "alkira_segment" "segment" {
  name = var.segment
}

locals {

  tag_id_list = [
    for v in data.alkira_billing_tag.tag : v.id
  ]

}

/*
alkira_connector_azure_vnet
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_azure_vnet
*/
resource "alkira_connector_azure_vnet" "connector" {
  billing_tag_ids  = local.tag_id_list
  azure_vnet_id    = var.azure_vnet_id
  credential_id    = data.alkira_credential.credential.id
  cxp              = var.cxp
  enabled          = var.enabled
  failover_cxps    = var.failover_cxps
  group            = data.alkira_group.group.name
  name             = var.name
  segment_id       = data.alkira_segment.segment.id
  size             = var.size
}