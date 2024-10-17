#!/bin/bash
private_endpoint_name=$1
resource_group_name=$2

# Get NIC name from the private endpoint
nic_name=$(az network private-endpoint show \
  --name "$private_endpoint_name" \
  --resource-group "$resource_group_name" \
  --query "networkInterfaces[0].id" -o tsv)

# Extract only the NIC name from the ID (last part)
nic_name=$(basename "$nic_name")

# Output NIC name as JSON for Terraform
if [ -n "$nic_name" ]; then
  echo "{\"nic_name\": \"$nic_name\"}"
else
  echo "{\"nic_name\": \"\"}"
fi
