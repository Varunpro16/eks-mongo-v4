
# Private DNS Zone for Cosmos DB
resource "azurerm_private_dns_zone" "private_dns" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = data.azurerm_resource_group.rg.name
}

# DNS Zone Virtual Network Link
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = var.dns_link_name
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# Private DNS A Record for Cosmos DB
data "azurerm_network_interface" "private_endpoint_nic" {
#   name                = "cosmosdb-private-endpoint.nic.761c9ae9-ddc9-4416-8bb3-6273470c12ca"
  name                = azurerm_private_endpoint.private_endpoint.private_service_connection[0].name
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_a_record" "private_dns_record" {
  name                = azurerm_cosmosdb_account.cosmosdb.name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300

  records = [data.azurerm_network_interface.private_endpoint_nic.private_ip_address]
}
