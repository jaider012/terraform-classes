# Module 2: Terraform Core Concepts

## Lesson 3: State Management and Workspaces

### Understanding Terraform State

Terraform state is a snapshot that maps real-world resources to your configuration, keeps track of metadata, and improves performance for large infrastructures.

#### Purpose of State

1. **Resource Mapping**: State maps Terraform configuration to real-world resources
2. **Metadata Storage**: Tracks resource dependencies and other metadata
3. **Performance Optimization**: Terraform uses state to determine what needs to be created, updated, or deleted

#### Default State Storage

By default, Terraform stores state locally in a file named `terraform.tfstate`. This file contains sensitive information (like database passwords) in plaintext, so it should be handled with care.

### Remote State

For team environments, storing state remotely is a better approach. This provides:

1. **Collaboration**: Multiple team members can access the state
2. **State Locking**: Prevents concurrent operations that could corrupt state
3. **Security**: Better management of sensitive data when used with proper access controls

#### Configuring Remote State

To configure remote state, use a backend configuration in your Terraform files:

```hcl
terraform {
  backend "gcs" {
    bucket  = "my-terraform-state"
    prefix  = "terraform/state"
  }
}
```

Common backend types include:
- `s3` for AWS S3
- `gcs` for Google Cloud Storage
- `azurerm` for Azure Blob Storage
- `remote` for Terraform Cloud

#### State Commands

Terraform provides several commands to manage state:

- `terraform state list`: List resources in the state
- `terraform state show <resource>`: Show details of a specific resource
- `terraform state mv <source> <destination>`: Move an item in the state
- `terraform state rm <resource>`: Remove an item from the state
- `terraform state pull`: Output the current state to stdout
- `terraform state push <file>`: Update state from a local state file

### Terraform Workspaces

Workspaces allow you to manage multiple state files for the same configuration. This is useful for managing different environments (like development, staging, and production) using the same Terraform code.

#### Creating and Using Workspaces

To create and switch between workspaces:

```bash
# Create a new workspace
terraform workspace new dev

# List available workspaces
terraform workspace list

# Switch to another workspace
terraform workspace select prod
```

The current workspace can be referenced in your configuration:

```hcl
resource "aws_instance" "example" {
  # ...
  tags = {
    Environment = terraform.workspace
  }
}
```

#### Workspace State Storage

Each workspace has its own state file:

- For local state, they're stored in a directory called `terraform.tfstate.d`
- For remote state, the exact storage structure depends on the backend

#### When to Use Workspaces

Workspaces are best suited for:
- Lightweight environment separation
- Testing changes before applying to production
- Small infrastructure differences between environments

For more complex environment management, consider using separate configurations with a shared module structure.

### Hands-on Exercise: Setting Up Remote State and Workspaces

#### 1. Create a GCS bucket for remote state

First, create a Google Cloud Storage bucket to store your state:

```bash
gsutil mb -l us-central1 gs://my-terraform-state-bucket
gsutil versioning set on gs://my-terraform-state-bucket
```

#### 2. Configure Terraform to use GCS for remote state

Create or update your `main.tf` file to include a backend configuration:

```hcl
terraform {
  backend "gcs" {
    bucket = "my-terraform-state-bucket"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# ... rest of your configuration
```

Run `terraform init` to initialize the backend.

#### 3. Create and use workspaces

Create workspaces for different environments:

```bash
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod
```

Switch to the dev workspace:

```bash
terraform workspace select dev
```

#### 4. Modify your configuration to use workspaces

Update your resources to use the workspace name:

```hcl
resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name}-${terraform.workspace}"
  machine_type = var.machine_type

  # ... rest of configuration
  
  tags = {
    environment = terraform.workspace
  }
}
```

#### 5. Deploy to different environments

Deploy to the dev environment:

```bash
terraform workspace select dev
terraform apply
```

Deploy to the staging environment:

```bash
terraform workspace select staging
terraform apply
```

### Best Practices for State Management

1. **Use remote backends** for team environments
2. **Enable versioning** on your state storage
3. **Use state locking** to prevent concurrent operations
4. **Restrict access** to your state files
5. **Don't edit state manually** unless absolutely necessary
6. **Back up your state** regularly
7. **Use workspaces or separate configurations** for different environments

### Next Steps

In the next module, we'll explore Advanced Terraform Features, including Modules, Data Sources, and more complex configuration techniques. 