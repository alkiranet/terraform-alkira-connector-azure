output "connector_id" {
  description = "ID of connector"
  value       = alkira_connector_azure_vnet.connector.id
}

output "implicit_group_id" {
  description = "ID of implicit group automatically created with connector"
  value       = alkira_connector_azure_vnet.connector.implicit_group_id
}