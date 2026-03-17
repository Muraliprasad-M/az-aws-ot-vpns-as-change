############################################
# Customer Gateway
############################################

resource "aws_customer_gateway" "cgw" {
  for_each = local.vpn_connections

  bgp_asn    = var.cgw_bgp_asn
  ip_address = each.value.ip
  type       = "ipsec.1"

  tags = merge(
    var.tags,
    {
      Name = format("%s-network-ss-vpn-azgw1-%s", var.domain, each.key)
    }
  )
}

############################################
# VPN Connection
############################################

resource "aws_vpn_connection" "vpn" {
  for_each = aws_customer_gateway.cgw

  customer_gateway_id = each.value.id
  transit_gateway_id  = var.tgw_id
  type                = "ipsec.1"
  static_routes_only  = false

  #######################################################
  # Tunnel 1 Logging (VPN logs including BGP events)
  #######################################################
  tunnel1_log_options {
    cloudwatch_log_options {
      log_enabled       = true
      log_group_arn     = aws_cloudwatch_log_group.vpn_tunnel_logs[each.key].arn
      log_output_format = "json"
    }
  }

  #######################################################
  # Tunnel 2 Logging (VPN logs including BGP events)
  #######################################################
  tunnel2_log_options {
    cloudwatch_log_options {
      log_enabled       = true
      log_group_arn     = aws_cloudwatch_log_group.vpn_tunnel_logs[each.key].arn
      log_output_format = "json"
    }
  }

  tags = merge(
    var.tags,
    {
      Name = format("%s-network-ss-vpn-azure-%s", var.domain, each.key)
    }
  )
}

############################################
# TGW Associations & Propagations
############################################

resource "aws_ec2_transit_gateway_route_table_association" "vpn_assoc" {
  for_each = aws_vpn_connection.vpn

  transit_gateway_attachment_id  = each.value.transit_gateway_attachment_id
  transit_gateway_route_table_id = var.tgw_rtb_id
  replace_existing_association   = true
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpn_prop" {
  for_each = aws_vpn_connection.vpn

  transit_gateway_attachment_id  = each.value.transit_gateway_attachment_id
  transit_gateway_route_table_id = var.tgw_rtb_id
}

############################################
# CloudWatch Log Groups for VPN Logs
############################################

resource "aws_cloudwatch_log_group" "vpn_tunnel_logs" {
  for_each = local.vpn_connections

  # Final naming pattern you requested
  name              = "/aws/vpn/az-${var.domain}-${each.key}/tunnel-vpn-log"
  retention_in_days = 365
  kms_key_id        = var.kms_key_arn


  tags = merge(
    var.tags,
    { Name = "az-${var.domain}-${each.key}-tunnel-vpn-log" }
  )
}