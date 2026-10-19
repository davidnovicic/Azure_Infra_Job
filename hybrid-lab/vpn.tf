resource "azurerm_public_ip" "vpn_gateway" {
  name                = "pip-vpn-gateway"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "VPN-Gateway"
  }
}

resource "azurerm_virtual_network_gateway" "site_to_site" {
  name                = "vng-hybrid-lab"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1AZ"

  active_active = false
  

  ip_configuration {
    name                          = "vng-ipconfig"
    public_ip_address_id          = azurerm_public_ip.vpn_gateway.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway.id
  }

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "VPN-Gateway"
  }
}

resource "azurerm_local_network_gateway" "on_prem" {
  name                = "lng-onprem"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name

  gateway_address = "68.210.224.110"

  address_space = [
    "10.10.0.0/16"
  ]

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "OnPrem-Gateway"
  }
}

resource "azurerm_virtual_network_gateway_connection" "site_to_site" {
  name                = "conn-hybrid-lab"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.site_to_site.id
  local_network_gateway_id  = azurerm_local_network_gateway.on_prem.id

  shared_key = var.vpn_shared_key

  ipsec_policy {
    dh_group         = "DHGroup14"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "AES256"
    ipsec_integrity  = "SHA256"
    pfs_group        = "PFS14"
  }

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "VPN-Connection"
  }
}

