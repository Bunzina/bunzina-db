# bunzina-db

This repository contains the Terraform configuration for the PostgreSQL RDS instance used by Bunzina.

## Structure

```text
infra/
├── backend.tf
├── versions.tf
├── variables.tf
├── locals.tf
├── db-subnet-group.tf
├── security-group.tf
├── parameter-group.tf
├── secrets.tf
├── rds.tf
├── outputs.tf
├── terraform.tfvars.example
└── README.md
```

## Requirements

- Terraform >= 1.6.0
- AWS provider ~> 5.0
- An existing VPC, private subnets and application security group or CIDR range
- An S3 backend configured externally via `backend.tf`

## Quick start

1. Copy the example file:

```bash
cp infra/terraform.tfvars.example infra/terraform.tfvars
```

2. Fill in the values for your environment, especially `vpc_id`, `subnet_ids`, and `allowed_*` rules.

3. Initialize Terraform:

```bash
cd infra
terraform init
```

4. Validate the configuration:

```bash
terraform validate
```

5. Review the execution plan:

```bash
terraform plan
```

## Notes

- The RDS instance is private-only and runs PostgreSQL 15.
- Credentials are stored in AWS Secrets Manager and only the non-sensitive metadata is exposed as outputs.
- The deployment intentionally keeps the setup minimal to match the ADR assumptions for a learning sandbox.
