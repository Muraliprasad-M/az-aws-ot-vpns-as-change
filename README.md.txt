
# CoreNetwork TGW → Azure VPN (ECMP Disabled)

This Terraform configuration deploys:
- OT domain → 2 VPNs (Active/Standby, ECMP disabled)
- IT domain → 1 VPN (Active/Standby, ECMP disabled)

## ECMP Disabled
ECMP is disabled using:
```
static_routes_only = true
```
This ensures:
- No BGP multipath
- One active tunnel at a time
- Backup tunnel failover works

## Run
```
terraform init
terraform plan -var-file="ot-prod.tfvars"
```
