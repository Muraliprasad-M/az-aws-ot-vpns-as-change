# Terraform AWS TGW VPN (Root Structure)

This repo creates AWS Site‑to‑Site VPN connections to a Transit Gateway.

## Features
- Automatically creates VPNs based on number of CGW IPs
- IT Domain → 1 VPN
- OT Domain → 2 VPNs
- Active/Standby
- ECMP disabled
- Works without Azure DevOps pipeline changes

## Usage

Initialize

terraform init

Plan IT

terraform plan -var-file=it.tfvars

Apply IT

terraform apply -var-file=it.tfvars

Plan OT

terraform plan -var-file=ot.tfvars

Apply OT

terraform apply -var-file=ot.tfvars