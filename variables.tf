variable "azure_vnet_id" {
  description  = "ID of Azure VNet that is being connected"
  type         = string
}

variable "billing_tags" {
  description  = "Billing tags associated with connector"
  type         = list(string)
  default      = []
}

variable "credential" {
  description  = "Name of credential to use for onboarding VNet"
  type         = string
}

variable "cxp" {
  description  = "CXP to provision connector in"
  type         = string
}

variable "failover_cxps" {
  description = "List of CXPs where connector should be provisioned for failover"
  type        = list(string)
  default     = []
}

variable "enabled" {
  description  = "Status of connector"
  type         = bool
  default      = true
}

variable "group" {
  description  = "Group to associate with connector"
  type         = string
  default      = ""
}

variable "name" {
  description  = "Name of connector"
  type         = string
}

variable "segment" {
  description  = "Segment to provision connector in"
  type         = string
}

variable "size" {
  description  = "Size of connector"
  type         = string
  default      = "SMALL"
}

variable "vnet_cidr" {
  description = "CIDR of Azure VNet that is being connected"

  type = list(object({
    cidr             = optional(string)
    prefix_lists     = optional(list(string), [])
    routing_options  = optional(string, "ADVERTISE_DEFAULT_ROUTE")
    service_tags     = optional(list(string))
  }))
  default = []
}

variable "vnet_subnet" {
  description = "Subnets to onboard in place of entire VNet CIDR block"

  type = list(object({
    prefix_lists     = optional(list(string), [])
    routing_options  = optional(string, "ADVERTISE_DEFAULT_ROUTE")
    service_tags     = optional(list(string))
    subnet_id        = optional(string)
    subnet_cidr      = optional(string)
  }))
  default = []
}