---
paths:
  - "**/*.tf"
  - "**/*.tfvars"
  - "**/scaler-oci-terraform/**"
  - "**/oci_example_redis/**"
---

# OCI Terraform Rules

## Resource Naming
- Use underscores in Terraform resource names, hyphens in OCI display names
- Always include compartment_id and tags on every resource
- Use variables for all OCI-specific values (tenancy OCID, compartment OCID, region)

## State Safety
- Never commit terraform.tfstate or terraform.tfvars (they may contain OCIDs and secrets)
- Always run `terraform plan` before `terraform apply`
- Keep .terraform.lock.hcl in version control

## OCI Specifics
- OCI provider source: hashicorp/oci
- Use data sources for images and availability domains — don't hardcode OCIDs
- Bastion service requires explicit NSG rules for SSH access
- OCI Cache (Redis) clusters require a dedicated subnet