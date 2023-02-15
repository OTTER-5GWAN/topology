# # not the prettiest outputs, but it'll do

output "azure_public_ips" {
  value = [
    module.azure_centralus_region.public_ip,
    module.azure_eastus_region.public_ip,
    module.azure_eastus2_region.public_ip,
    module.azure_northcentralus_region.public_ip,
    module.azure_southcentralus_region.public_ip,
    module.azure_westcentralus_region.public_ip,
    module.azure_westus_region.public_ip,
    module.azure_westus3_region.public_ip,
  ]
}


output "azure_private_ips" {
  value = [
    module.azure_centralus_region.private_ip,
    module.azure_eastus_region.private_ip,
    module.azure_eastus2_region.private_ip,
    module.azure_northcentralus_region.private_ip,
    module.azure_southcentralus_region.private_ip,
    module.azure_westcentralus_region.private_ip,
    module.azure_westus_region.private_ip,
    module.azure_westus3_region.private_ip,
  ]
}

output "azure_private_app_ips" {
  value = [
    module.azure_centralus_app_vm1.private_ip,
    module.azure_eastus_app_vm1.private_ip,
    module.azure_eastus2_app_vm1.private_ip,
    module.azure_northcentralus_app_vm1.private_ip,
    module.azure_southcentralus_app_vm1.private_ip,
    module.azure_westcentralus_app_vm1.private_ip,
    module.azure_westus_app_vm1.private_ip,
    module.azure_westus3_app_vm1.private_ip,
    module.azure_centralus_app_vm2.private_ip,
    module.azure_eastus_app_vm2.private_ip,
    module.azure_eastus2_app_vm2.private_ip,
    module.azure_northcentralus_app_vm2.private_ip,
    module.azure_southcentralus_app_vm2.private_ip,
    module.azure_westcentralus_app_vm2.private_ip,
    module.azure_westus_app_vm2.private_ip,
    module.azure_westus3_app_vm2.private_ip,
    module.azure_centralus_app_vm3.private_ip,
    module.azure_eastus_app_vm3.private_ip,
    module.azure_eastus2_app_vm3.private_ip,
    module.azure_northcentralus_app_vm3.private_ip,
    module.azure_southcentralus_app_vm3.private_ip,
    module.azure_westcentralus_app_vm3.private_ip,
    module.azure_westus_app_vm3.private_ip,
    module.azure_westus3_app_vm3.private_ip,
    module.azure_centralus_app_vm4.private_ip,
    module.azure_eastus_app_vm4.private_ip,
    module.azure_eastus2_app_vm4.private_ip,
    module.azure_northcentralus_app_vm4.private_ip,
    module.azure_southcentralus_app_vm4.private_ip,
    module.azure_westcentralus_app_vm4.private_ip,
    module.azure_westus_app_vm4.private_ip,
    module.azure_westus3_app_vm4.private_ip,
    module.azure_centralus_app_vm5.private_ip,
    module.azure_eastus_app_vm5.private_ip,
    module.azure_eastus2_app_vm5.private_ip,
    module.azure_northcentralus_app_vm5.private_ip,
    module.azure_southcentralus_app_vm5.private_ip,
    module.azure_westcentralus_app_vm5.private_ip,
    module.azure_westus_app_vm5.private_ip,
    module.azure_westus3_app_vm5.private_ip,
    module.azure_centralus_app_vm6.private_ip,
    module.azure_eastus_app_vm6.private_ip,
    module.azure_eastus2_app_vm6.private_ip,
    module.azure_northcentralus_app_vm6.private_ip,
    module.azure_southcentralus_app_vm6.private_ip,
    module.azure_westcentralus_app_vm6.private_ip,
    module.azure_westus_app_vm6.private_ip,
    module.azure_westus3_app_vm6.private_ip,
    module.azure_centralus_app_vm7.private_ip,
    module.azure_eastus_app_vm7.private_ip,
    module.azure_eastus2_app_vm7.private_ip,
    module.azure_northcentralus_app_vm7.private_ip,
    module.azure_southcentralus_app_vm7.private_ip,
    module.azure_westcentralus_app_vm7.private_ip,
    module.azure_westus_app_vm7.private_ip,
    module.azure_westus3_app_vm7.private_ip,
    module.azure_centralus_app_vm8.private_ip,
    module.azure_eastus_app_vm8.private_ip,
    module.azure_eastus2_app_vm8.private_ip,
    module.azure_northcentralus_app_vm8.private_ip,
    module.azure_southcentralus_app_vm8.private_ip,
    module.azure_westcentralus_app_vm8.private_ip,
    module.azure_westus_app_vm8.private_ip,
    module.azure_westus3_app_vm8.private_ip,

  ]
}

output "azure_public_app_ips" {
  value = [
    module.azure_centralus_app_vm1.public_ip,
    module.azure_eastus_app_vm1.public_ip,
    module.azure_eastus2_app_vm1.public_ip,
    module.azure_northcentralus_app_vm1.public_ip,
    module.azure_southcentralus_app_vm1.public_ip,
    module.azure_westcentralus_app_vm1.public_ip,
    module.azure_westus_app_vm1.public_ip,
    module.azure_westus3_app_vm1.public_ip,
    module.azure_centralus_app_vm2.public_ip,
    module.azure_eastus_app_vm2.public_ip,
    module.azure_eastus2_app_vm2.public_ip,
    module.azure_northcentralus_app_vm2.public_ip,
    module.azure_southcentralus_app_vm2.public_ip,
    module.azure_westcentralus_app_vm2.public_ip,
    module.azure_westus_app_vm2.public_ip,
    module.azure_westus3_app_vm2.public_ip,
    module.azure_centralus_app_vm3.public_ip,
    module.azure_eastus_app_vm3.public_ip,
    module.azure_eastus2_app_vm3.public_ip,
    module.azure_northcentralus_app_vm3.public_ip,
    module.azure_southcentralus_app_vm3.public_ip,
    module.azure_westcentralus_app_vm3.public_ip,
    module.azure_westus_app_vm3.public_ip,
    module.azure_westus3_app_vm3.public_ip,
    module.azure_centralus_app_vm4.public_ip,
    module.azure_eastus_app_vm4.public_ip,
    module.azure_eastus2_app_vm4.public_ip,
    module.azure_northcentralus_app_vm4.public_ip,
    module.azure_southcentralus_app_vm4.public_ip,
    module.azure_westcentralus_app_vm4.public_ip,
    module.azure_westus_app_vm4.public_ip,
    module.azure_westus3_app_vm4.public_ip,
    module.azure_centralus_app_vm5.public_ip,
    module.azure_eastus_app_vm5.public_ip,
    module.azure_eastus2_app_vm5.public_ip,
    module.azure_northcentralus_app_vm5.public_ip,
    module.azure_southcentralus_app_vm5.public_ip,
    module.azure_westcentralus_app_vm5.public_ip,
    module.azure_westus_app_vm5.public_ip,
    module.azure_westus3_app_vm5.public_ip,
    module.azure_centralus_app_vm6.public_ip,
    module.azure_eastus_app_vm6.public_ip,
    module.azure_eastus2_app_vm6.public_ip,
    module.azure_northcentralus_app_vm6.public_ip,
    module.azure_southcentralus_app_vm6.public_ip,
    module.azure_westcentralus_app_vm6.public_ip,
    module.azure_westus_app_vm6.public_ip,
    module.azure_westus3_app_vm6.public_ip,
    module.azure_centralus_app_vm7.public_ip,
    module.azure_eastus_app_vm7.public_ip,
    module.azure_eastus2_app_vm7.public_ip,
    module.azure_northcentralus_app_vm7.public_ip,
    module.azure_southcentralus_app_vm7.public_ip,
    module.azure_westcentralus_app_vm7.public_ip,
    module.azure_westus_app_vm7.public_ip,
    module.azure_westus3_app_vm7.public_ip,
    module.azure_centralus_app_vm8.public_ip,
    module.azure_eastus_app_vm8.public_ip,
    module.azure_eastus2_app_vm8.public_ip,
    module.azure_northcentralus_app_vm8.public_ip,
    module.azure_southcentralus_app_vm8.public_ip,
    module.azure_westcentralus_app_vm8.public_ip,
    module.azure_westus_app_vm8.public_ip,
    module.azure_westus3_app_vm8.public_ip,

  ]
}

output "azure_vms" {
  value = [
    module.azure_centralus_region.name_vm,
    module.azure_eastus_region.name_vm,
    module.azure_eastus2_region.name_vm,
    module.azure_northcentralus_region.name_vm,
    module.azure_southcentralus_region.name_vm,
    module.azure_westcentralus_region.name_vm,
    module.azure_westus_region.name_vm,
    module.azure_westus3_region.name_vm,
  ]
}


output "azure_app_vms" {
  value = [
    module.azure_centralus_app_vm1.name_vm,
    module.azure_eastus_app_vm1.name_vm,
    module.azure_eastus2_app_vm1.name_vm,
    module.azure_northcentralus_app_vm1.name_vm,
    module.azure_southcentralus_app_vm1.name_vm,
    module.azure_westcentralus_app_vm1.name_vm,
    module.azure_westus_app_vm1.name_vm,
    module.azure_westus3_app_vm1.name_vm,
    module.azure_centralus_app_vm2.name_vm,
    module.azure_eastus_app_vm2.name_vm,
    module.azure_eastus2_app_vm2.name_vm,
    module.azure_northcentralus_app_vm2.name_vm,
    module.azure_southcentralus_app_vm2.name_vm,
    module.azure_westcentralus_app_vm2.name_vm,
    module.azure_westus_app_vm2.name_vm,
    module.azure_westus3_app_vm2.name_vm,
    module.azure_centralus_app_vm3.name_vm,
    module.azure_eastus_app_vm3.name_vm,
    module.azure_eastus2_app_vm3.name_vm,
    module.azure_northcentralus_app_vm3.name_vm,
    module.azure_southcentralus_app_vm3.name_vm,
    module.azure_westcentralus_app_vm3.name_vm,
    module.azure_westus_app_vm3.name_vm,
    module.azure_westus3_app_vm3.name_vm,
    module.azure_centralus_app_vm4.name_vm,
    module.azure_eastus_app_vm4.name_vm,
    module.azure_eastus2_app_vm4.name_vm,
    module.azure_northcentralus_app_vm4.name_vm,
    module.azure_southcentralus_app_vm4.name_vm,
    module.azure_westcentralus_app_vm4.name_vm,
    module.azure_westus_app_vm4.name_vm,
    module.azure_westus3_app_vm4.name_vm,
    module.azure_centralus_app_vm5.name_vm,
    module.azure_eastus_app_vm5.name_vm,
    module.azure_eastus2_app_vm5.name_vm,
    module.azure_northcentralus_app_vm5.name_vm,
    module.azure_southcentralus_app_vm5.name_vm,
    module.azure_westcentralus_app_vm5.name_vm,
    module.azure_westus_app_vm5.name_vm,
    module.azure_westus3_app_vm5.name_vm,
    module.azure_centralus_app_vm6.name_vm,
    module.azure_eastus_app_vm6.name_vm,
    module.azure_eastus2_app_vm6.name_vm,
    module.azure_northcentralus_app_vm6.name_vm,
    module.azure_southcentralus_app_vm6.name_vm,
    module.azure_westcentralus_app_vm6.name_vm,
    module.azure_westus_app_vm6.name_vm,
    module.azure_westus3_app_vm6.name_vm,
    module.azure_centralus_app_vm7.name_vm,
    module.azure_eastus_app_vm7.name_vm,
    module.azure_eastus2_app_vm7.name_vm,
    module.azure_northcentralus_app_vm7.name_vm,
    module.azure_southcentralus_app_vm7.name_vm,
    module.azure_westcentralus_app_vm7.name_vm,
    module.azure_westus_app_vm7.name_vm,
    module.azure_westus3_app_vm7.name_vm,
    module.azure_centralus_app_vm8.name_vm,
    module.azure_eastus_app_vm8.name_vm,
    module.azure_eastus2_app_vm8.name_vm,
    module.azure_northcentralus_app_vm8.name_vm,
    module.azure_southcentralus_app_vm8.name_vm,
    module.azure_westcentralus_app_vm8.name_vm,
    module.azure_westus_app_vm8.name_vm,
    module.azure_westus3_app_vm8.name_vm,

  ]
}


output "azure_vnets" {
  value = [
    module.azure_centralus_region.vnet_name,
    module.azure_eastus_region.vnet_name,
    module.azure_eastus2_region.vnet_name,
    module.azure_northcentralus_region.vnet_name,
    module.azure_southcentralus_region.vnet_name,
    module.azure_westcentralus_region.vnet_name,
    module.azure_westus_region.vnet_name,
    module.azure_westus3_region.vnet_name,
  ]
}


output "azure_app_vnets" {
  value = [
    module.azure_centralus_app_region.vnet_name1,
    module.azure_eastus_app_region.vnet_name1,
    module.azure_eastus2_app_region.vnet_name1,
    module.azure_northcentralus_app_region.vnet_name1,
    module.azure_southcentralus_app_region.vnet_name1,
    module.azure_westcentralus_app_region.vnet_name1,
    module.azure_westus_app_region.vnet_name1,
    module.azure_westus3_app_region.vnet_name1,
    module.azure_centralus_app_region.vnet_name2,
    module.azure_eastus_app_region.vnet_name2,
    module.azure_eastus2_app_region.vnet_name2,
    module.azure_northcentralus_app_region.vnet_name2,
    module.azure_southcentralus_app_region.vnet_name2,
    module.azure_westcentralus_app_region.vnet_name2,
    module.azure_westus_app_region.vnet_name2,
    module.azure_westus3_app_region.vnet_name2,
    module.azure_centralus_app_region.vnet_name3,
    module.azure_eastus_app_region.vnet_name3,
    module.azure_eastus2_app_region.vnet_name3,
    module.azure_northcentralus_app_region.vnet_name3,
    module.azure_southcentralus_app_region.vnet_name3,
    module.azure_westcentralus_app_region.vnet_name3,
    module.azure_westus_app_region.vnet_name3,
    module.azure_westus3_app_region.vnet_name3,
    module.azure_centralus_app_region.vnet_name4,
    module.azure_eastus_app_region.vnet_name4,
    module.azure_eastus2_app_region.vnet_name4,
    module.azure_northcentralus_app_region.vnet_name4,
    module.azure_southcentralus_app_region.vnet_name4,
    module.azure_westcentralus_app_region.vnet_name4,
    module.azure_westus_app_region.vnet_name4,
    module.azure_westus3_app_region.vnet_name4,
    module.azure_centralus_app_region.vnet_name5,
    module.azure_eastus_app_region.vnet_name5,
    module.azure_eastus2_app_region.vnet_name5,
    module.azure_northcentralus_app_region.vnet_name5,
    module.azure_southcentralus_app_region.vnet_name5,
    module.azure_westcentralus_app_region.vnet_name5,
    module.azure_westus_app_region.vnet_name5,
    module.azure_westus3_app_region.vnet_name5,
    module.azure_centralus_app_region.vnet_name6,
    module.azure_eastus_app_region.vnet_name6,
    module.azure_eastus2_app_region.vnet_name6,
    module.azure_northcentralus_app_region.vnet_name6,
    module.azure_southcentralus_app_region.vnet_name6,
    module.azure_westcentralus_app_region.vnet_name6,
    module.azure_westus_app_region.vnet_name6,
    module.azure_westus3_app_region.vnet_name6,
    module.azure_centralus_app_region.vnet_name7,
    module.azure_eastus_app_region.vnet_name7,
    module.azure_eastus2_app_region.vnet_name7,
    module.azure_northcentralus_app_region.vnet_name7,
    module.azure_southcentralus_app_region.vnet_name7,
    module.azure_westcentralus_app_region.vnet_name7,
    module.azure_westus_app_region.vnet_name7,
    module.azure_westus3_app_region.vnet_name7,
    module.azure_centralus_app_region.vnet_name8,
    module.azure_eastus_app_region.vnet_name8,
    module.azure_eastus2_app_region.vnet_name8,
    module.azure_northcentralus_app_region.vnet_name8,
    module.azure_southcentralus_app_region.vnet_name8,
    module.azure_westcentralus_app_region.vnet_name8,
    module.azure_westus_app_region.vnet_name8,
    module.azure_westus3_app_region.vnet_name8,

  ]
}

output "gcp_public_ips" {
  value = [
    module.gcp_us_central1_region.public_ip,
    module.gcp_us_east1_region.public_ip,
    module.gcp_us_east4_region.public_ip,
    module.gcp_us_east5_region.public_ip,
    module.gcp_us_south1_region.public_ip,
    module.gcp_us_west3_region.public_ip,
    module.gcp_us_west2_region.public_ip,
    module.gcp_us_west4_region.public_ip,
  ]
}


output "gcp_private_ips" {
  value = [
    module.gcp_us_central1_region.private_ip,
    module.gcp_us_east1_region.private_ip,
    module.gcp_us_east4_region.private_ip,
    module.gcp_us_east5_region.private_ip,
    module.gcp_us_south1_region.private_ip,
    module.gcp_us_west3_region.private_ip,
    module.gcp_us_west2_region.private_ip,
    module.gcp_us_west4_region.private_ip,
  ]
}

output "gcp_vms" {
  value = [
    module.gcp_us_central1_region.name_vm,
    module.gcp_us_east1_region.name_vm,
    module.gcp_us_east4_region.name_vm,
    module.gcp_us_east5_region.name_vm,
    module.gcp_us_south1_region.name_vm,
    module.gcp_us_west3_region.name_vm,
    module.gcp_us_west2_region.name_vm,
    module.gcp_us_west4_region.name_vm,
  ]
}

output "gcp_regions" {
  value = [
    module.gcp_us_central1_region.name_region,
    module.gcp_us_east1_region.name_region,
    module.gcp_us_east4_region.name_region,
    module.gcp_us_east5_region.name_region,
    module.gcp_us_south1_region.name_region,
    module.gcp_us_west3_region.name_region,
    module.gcp_us_west2_region.name_region,
    module.gcp_us_west4_region.name_region,
  ]
}

output "azure_fws" {
    value = [
    module.azure_centralus_region.name_fw,
    module.azure_eastus_region.name_fw,
    module.azure_eastus2_region.name_fw,
    module.azure_northcentralus_region.name_fw,
    module.azure_southcentralus_region.name_fw,
    module.azure_westcentralus_region.name_fw,
    module.azure_westus_region.name_fw,
    module.azure_westus3_region.name_fw,
  ]
}

output "azure_fw_ips" {
value = [
    module.azure_centralus_region.fw_ip,
    module.azure_eastus_region.fw_ip,
    module.azure_eastus2_region.fw_ip,
    module.azure_northcentralus_region.fw_ip,
    module.azure_southcentralus_region.fw_ip,
    module.azure_westcentralus_region.fw_ip,
    module.azure_westus_region.fw_ip,
    module.azure_westus3_region.fw_ip,
  ]
}

output "azure_vm_rts" {
value = [
    module.azure_centralus_region.name_vm_rt,
    module.azure_eastus_region.name_vm_rt,
    module.azure_eastus2_region.name_vm_rt,
    module.azure_northcentralus_region.name_vm_rt,
    module.azure_southcentralus_region.name_vm_rt,
    module.azure_westcentralus_region.name_vm_rt,
    module.azure_westus_region.name_vm_rt,
    module.azure_westus3_region.name_vm_rt,
  ]
}

output "azure_fw_rts" {
value = [
    module.azure_centralus_region.name_fw_rt,
    module.azure_eastus_region.name_fw_rt,
    module.azure_eastus2_region.name_fw_rt,
    module.azure_northcentralus_region.name_fw_rt,
    module.azure_southcentralus_region.name_fw_rt,
    module.azure_westcentralus_region.name_fw_rt,
    module.azure_westus_region.name_fw_rt,
    module.azure_westus3_region.name_fw_rt,
  ]
}
