locals {
  vpn_connections = {
    for idx, ip in var.cgw_public_ips :
    "vpn-${idx}" => {
      ip = ip
    }
  }
}