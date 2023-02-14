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

data "alkira_policy_prefix_list" "cidr_pfx" {
  for_each = {
    for k, v in toset(local.cidr_prefixes) : k => v
  }
  name     = each.key
}

data "alkira_policy_prefix_list" "subnet_pfx" {
  for_each = {
    for k, v in toset(local.subnet_prefixes) : k => v
  }
  name     = each.key
}

data "alkira_segment" "segment" {
  name = var.segment
}

locals {

  tag_id_list = [
    for v in data.alkira_billing_tag.tag : v.id
  ]

  cidr_prefixes = flatten([
    for cidr in var.vnet_cidr : [
      for pfx in cidr.prefix_lists : 
        pfx
    ]
  ])

  subnet_prefixes = flatten([
    for subnet in var.vnet_subnet : [
      for pfx in subnet.prefix_lists : 
        pfx
    ]
  ])


  filter_cidr_options = flatten([
    for r in var.vnet_cidr : {
      cidr             = r.cidr
      prefix_list_ids  = [for pfx in r.prefix_lists : lookup(data.alkira_policy_prefix_list.cidr_pfx, pfx, null).id]
      routing_options  = r.routing_options
      service_tags     = r.service_tags
    }
  ])

  filter_subnet_options = flatten([
    for r in var.vnet_subnet : {
      prefix_list_ids  = [for pfx in r.prefix_lists : lookup(data.alkira_policy_prefix_list.subnet_pfx, pfx, null).id]
      routing_options  = r.routing_options
      service_tags     = r.service_tags
      subnet_cidr      = r.subnet_cidr
      subnet_id        = r.subnet_id
    }
  ])


}

/*
alkira_connector_azure_vnet
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_azure_vnet
*/
resource "alkira_connector_azure_vnet" "connector" {
  azure_vnet_id    = var.azure_vnet_id
  billing_tag_ids  = local.tag_id_list
  credential_id    = data.alkira_credential.credential.id
  cxp              = var.cxp
  enabled          = var.enabled
  failover_cxps    = var.failover_cxps
  group            = data.alkira_group.group.name
  name             = var.name
  segment_id       = data.alkira_segment.segment.id
  size             = var.size

  # Onboard VNet CIDR and all associated subnets
  dynamic "vnet_cidr" {
    for_each = {
      for o in local.filter_cidr_options : o.cidr => o
    }

    content {
      cidr             = vnet_cidr.value.cidr
      prefix_list_ids  = vnet_cidr.value.prefix_list_ids
      routing_options  = vnet_cidr.value.routing_options
      service_tags     = vnet_cidr.value.service_tags
    }

  }

  # Onboard specific subnet(s) in place of entire VNet CIDR
  dynamic "vnet_subnet" {
    for_each = {
      for o in local.filter_subnet_options : o.subnet_id => o
    }

    content {
      prefix_list_ids  = vnet_subnet.value.prefix_list_ids
      routing_options  = vnet_subnet.value.routing_options
      service_tags     = vnet_subnet.value.service_tags
      subnet_cidr      = vnet_subnet.value.subnet_cidr
      subnet_id        = vnet_subnet.value.subnet_id
    }

  }

}