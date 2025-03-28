# Lesson 1: Introduction to Terraform

## Learning Objectives
- Understand what Infrastructure as Code (IaC) is
- Learn about Terraform and its benefits
- Set up your Terraform development environment
- Write your first Terraform configuration

## What is Infrastructure as Code (IaC)?

Infrastructure as Code (IaC) is the practice of managing and provisioning infrastructure through code instead of manual processes. It allows you to:
- Version control your infrastructure
- Automate infrastructure deployment
- Ensure consistency across environments
- Reduce human error
- Enable collaboration

## What is Terraform?

Terraform is an open-source Infrastructure as Code tool created by HashiCorp. It allows you to:
- Define infrastructure using a declarative configuration language
- Manage multiple cloud providers
- Track infrastructure state
- Automate infrastructure changes

## Installing Terraform

### macOS Installation
Using Homebrew:
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### Verify Installation
```bash
terraform --version
```

## Your First Terraform Configuration

Let's create a simple configuration that will create a local file. Create a new file called `main.tf`:

```hcl
# Configure the provider (in this case, local)
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# Create a local file
resource "local_file" "hello" {
  content  = "Hello, Terraform!"
  filename = "hello.txt"
}
```

## Basic Terraform Commands

1. Initialize Terraform:
```bash
terraform init
```

2. See what changes will be made:
```bash
terraform plan
```

3. Apply the changes:
```bash
terraform apply
```

4. Destroy the infrastructure:
```bash
terraform destroy
```

## Practice Exercise

1. Create a new directory for your first Terraform project
2. Create the `main.tf` file with the configuration above
3. Run the Terraform commands in sequence
4. Verify that the file was created
5. Try modifying the content and applying the changes

## Next Steps
- Learn about Terraform providers
- Understand resource blocks
- Explore variables and outputs
- Practice with more complex configurations

## Additional Resources
- [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Terraform Configuration Language](https://www.terraform.io/docs/language/index.html)
- [Terraform Providers](https://registry.terraform.io/) 