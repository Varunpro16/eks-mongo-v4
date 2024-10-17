# Subnet for Private Endpoint
resource "azurerm_subnet" "private_endpoint_subnet" {
  name                             = "private-endpoint-subnet"
  resource_group_name              = data.azurerm_resource_group.rg.name
  virtual_network_name             = azurerm_virtual_network.vnet.name
  address_prefixes                 = ["10.0.1.0/24"]
}

# AKS Cluster Subnet
resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

