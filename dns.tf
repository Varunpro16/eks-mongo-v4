
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
data "external" "private_endpoint_nic" {
  program = ["bash", "./get_nic_name.sh", "cosmosdb-private-endpoint", "AKS-POC"]
}

output "nic_name" {
  value = data.external.private_endpoint_nic.result["nic_name"]
}


data "azurerm_network_interface" "private_endpoint_nic" {
  name                = data.external.private_endpoint_nic.result["nic_name"]
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_a_record" "private_dns_record" {
  name                = azurerm_cosmosdb_account.cosmosdb.name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records = [
    data.azurerm_network_interface.private_endpoint_nic.private_ip_address != null ?
      data.azurerm_network_interface.private_endpoint_nic.private_ip_address :
      "0.0.0.0"  # Dummy IP address during plan phase
  ]
}
