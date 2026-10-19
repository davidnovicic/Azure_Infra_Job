resource "azurerm_resource_group" "hybrid_lab" {
  name     = "rg-hybrid-lab"
  location = "Austria East"

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
  }
}

resource "azurerm_virtual_network" "on_prem" {
  name                = "vnet-onprem"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name
  address_space       = ["10.10.0.0/16"]

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Network     = "OnPrem"
  }
}

resource "azurerm_subnet" "on_prem_firewall" {
  name                 = "snet-firewall"
  resource_group_name  = azurerm_resource_group.hybrid_lab.name
  virtual_network_name = azurerm_virtual_network.on_prem.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet" "on_prem_server" {
  name                 = "snet-server"
  resource_group_name  = azurerm_resource_group.hybrid_lab.name
  virtual_network_name = azurerm_virtual_network.on_prem.name
  address_prefixes     = ["10.10.10.0/24"]
}

resource "azurerm_virtual_network" "cloud" {
  name                = "vnet-cloud"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name
  address_space       = ["10.20.0.0/16"]

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Network     = "Cloud"
  }
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hybrid_lab.name
  virtual_network_name = azurerm_virtual_network.cloud.name
  address_prefixes     = ["10.20.1.0/24"]
}

resource "azurerm_subnet" "cloud_client" {
  name                 = "snet-client"
  resource_group_name  = azurerm_resource_group.hybrid_lab.name
  virtual_network_name = azurerm_virtual_network.cloud.name
  address_prefixes     = ["10.20.10.0/24"]
}