# Practice Exercise: Multi-Environment Infrastructure

## Objective

Create a Terraform configuration that can be used to deploy infrastructure across multiple environments (dev, staging, and production) using variables, outputs, and workspaces.

## Requirements

1. Create a configuration that provisions a Google Cloud infrastructure with:
   - A Virtual Private Cloud (VPC) network
   - Subnets for each environment with different CIDR ranges
   - A Google Compute Engine instance in each subnet
   - Firewall rules to allow SSH access

2. Use variables to make your configuration flexible:
   - Project ID
   - Region and zone
   - Network name
   - CIDR ranges
   - Instance types (different for each environment)

3. Use outputs to display:
   - VPC ID
   - Subnet IDs
   - Instance IPs
   - Firewall rule names

4. Use workspaces to manage different environments:
   - Create dev, staging, and prod workspaces
   - Configure different instance types based on the workspace
   - Use the workspace name in resource naming

5. Configure remote state using a Google Cloud Storage bucket

## Getting Started

1. Create a directory structure:
   ```
   multi-environment/
   ├── main.tf         # Main configuration
   ├── variables.tf    # Variable definitions
   ├── outputs.tf      # Output definitions
   ├── network.tf      # Network resources
   ├── compute.tf      # Compute resources
   └── terraform.tfvars # Variable values
   ```

2. Start by defining your variables in `variables.tf`
3. Create the main infrastructure in the other files
4. Test your configuration with `terraform plan` and `terraform apply`

## Expected Outcome

You should be able to:
- Switch between workspaces and deploy different environments
- See the environment name reflected in resource names
- Have different machine types for each environment
- View outputs specific to each environment

## Bonus Challenge

1. Add IAM roles and service accounts
2. Implement a module structure for your resources
3. Add conditional resources that only exist in specific environments

## Solution

A sample solution is provided in the `solution` directory. Try to complete the exercise before checking the solution. 