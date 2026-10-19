variable "vm-firewall_admin_password" {
  description = "Administrator password for the pfSense VM"
  type        = string
  sensitive   = true
}

variable "vpn_shared_key" {
  description = "Pre-shared key for the site-to-site IPsec VPN"
  type        = string
  sensitive   = true
}

variable "domain_controller_admin_password" {
  description = "Administrator password for the Windows Server domain controller"
  type        = string
  sensitive   = true
}