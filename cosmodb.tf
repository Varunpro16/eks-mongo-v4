
# Cosmos DB Account (MongoDB API)
resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = var.cosmosdb_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "MongoDB"

  consistency_policy {
    consistency_level = "Session"
  }

  capabilities {
    name = "EnableMongo"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

