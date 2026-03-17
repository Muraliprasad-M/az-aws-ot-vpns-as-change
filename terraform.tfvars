aws_region = "eu-west-2"
env        = "prod"
domain     = "ot"

tgw_id     = "tgw-046432679404c0c8e"
tgw_rtb_id = "tgw-rtb-00ca28a14ca8a206d"

vpc_id = "vpc-08d937b89707ea8ac"

tgw_subnet_ids = [
  "subnet-0ba3462654aaafb54",
  "subnet-0fd76b1d3f1bc7523",
  "subnet-072adb60a59888568"
]

cgw_public_ips = [
  "4.159.61.37",
  "40.127.209.247"
]

cgw_bgp_asn = 65515

tags = {
  project = "corenetwork"
  domain  = "ot"
}

kms_key_arn = "arn:aws:kms:eu-west-2:732822664028:key/6bdb429b-1b63-4f69-9720-b2b1201760ce"