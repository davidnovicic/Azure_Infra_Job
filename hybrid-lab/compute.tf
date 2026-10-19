resource "azurerm_public_ip" "vm-firewall" {
  name                = "pip-vm-firewall"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name

  allocation_method = "Static"
  sku               = "Standard"

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "Firewall"
  }
}

resource "azurerm_network_interface" "vm-firewall" {
  name                = "nic-vm-firewall"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name
  ip_forwarding_enabled =            true

  ip_configuration {
    name                          = "ipconfig-vm-firewall"
    subnet_id                     = azurerm_subnet.on_prem_firewall.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm-firewall.id
    
  }

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "Firewall"
  }
}

resource "azurerm_network_interface" "firewall_lan" {
  name                = "nic-vm-firewall-lan"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name
  ip_forwarding_enabled =            true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.on_prem_server.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "Firewall-LAN"
  }
}

resource "azurerm_linux_virtual_machine" "vm-firewall" {
  name                = "vm-firewall"
  resource_group_name = azurerm_resource_group.hybrid_lab.name
  location            = azurerm_resource_group.hybrid_lab.location
  size                = "Standard_DS2_v2"
  zone                = "1"

  admin_username = "azureadmin"

  network_interface_ids = [
    azurerm_network_interface.vm-firewall.id,
    azurerm_network_interface.firewall_lan.id
  ]

  disable_password_authentication = false
  admin_password                  = var.vm-firewall_admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server-gen1"
    version   = "latest"
  }

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "Firewall"
  }
}

resource "azurerm_network_interface" "domain_controller" {
  name                = "nic-domain-controller"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name

  ip_forwarding_enabled = false

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.on_prem_server.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.10.10.10"

    public_ip_address_id = azurerm_public_ip.domain_controller.id
  }

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "Domain-Controller"
  }
}

resource "azurerm_windows_virtual_machine" "domain_controller" {
  name                = "domain-cntrl"
  resource_group_name = azurerm_resource_group.hybrid_lab.name
  location            = azurerm_resource_group.hybrid_lab.location
  size                = "Standard_B2s_v2"
  zone                = "1"

  admin_username = "azureadmin"
  admin_password = var.domain_controller_admin_password

  patch_mode = "AutomaticByPlatform"

  network_interface_ids = [
    azurerm_network_interface.domain_controller.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-azure-edition"
    version   = "latest"
  }

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "Domain-Controller"
  }
}

resource "azurerm_public_ip" "domain_controller" {
  name                = "pip-domain-controller"
  location            = azurerm_resource_group.hybrid_lab.location
  resource_group_name = azurerm_resource_group.hybrid_lab.name

  allocation_method = "Static"
  sku               = "Standard"

  tags = {
    Project     = "HybridIdentityLab"
    Environment = "Lab"
    Role        = "Domain-Controller"
  }
}

