# bunzina-db

This repository contains the Terraform configuration for the PostgreSQL workload used by Bunzina inside EKS.

## Structure

```text
README.md
infra/
├── backend.tf
├── versions.tf
├── variables.tf
├── locals.tf
├── remote-state.tf
├── postgres.tf
├── outputs.tf
├── terraform.tfvars.example
```

## Requirements

- Terraform >= 1.6.0
- AWS provider ~> 5.0
- Kubernetes provider ~> 2.38
- An existing `bunzina-infra` state in S3 with the EKS cluster output
- An S3 backend configured externally via `backend.tf`

## Quick start

1. Copy the example file:

```bash
cp infra/terraform.tfvars.example infra/terraform.tfvars
```

2. Fill in the environment and sizing values. The EKS cluster name is read
   from the `bunzina-infra` remote state.

3. Initialize Terraform:

```bash
cd infra
terraform init
```

The database module reads the EKS cluster name from the `bunzina-infra` remote
state. Provide the shared state bucket without committing it to `terraform.tfvars`:

```bash
export TF_VAR_infra_state_bucket="your-state-bucket"
```

The infrastructure state must use the key configured by `infra_state_key`,
which defaults to `bunzina/infra/dev/terraform.tfstate`.

The S3 backend configured with `terraform init` stores the state of this
repository. It may use the same physical bucket, but must use a different key,
such as `bunzina/db/dev/terraform.tfstate`.

4. Validate the configuration:

```bash
terraform validate
```

5. Review the execution plan:

```bash
terraform plan
```

6. Apply the database resources:

```bash
export TF_VAR_db_password="the-value-used-by-the-application"
terraform apply
```

## Notes

- PostgreSQL 15 runs as a single-replica Deployment with a `gp3` EBS-backed PVC.
- The `gp3` StorageClass is created by this module after `bunzina-infra` creates the EKS cluster.
- The `postgres` ClusterIP Service is available only inside the cluster.
- The PostgreSQL password is supplied as `TF_VAR_db_password` and stored in the
	Kubernetes Secret managed by Terraform. Do not commit it to `terraform.tfvars`.
- Backups, failover, upgrades and recovery remain operational responsibilities of the EKS deployment.
