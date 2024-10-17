# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vpc_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.vpc_address_range
}


