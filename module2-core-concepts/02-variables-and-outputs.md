# Module 2: Terraform Core Concepts

## Lesson 2: Variables and Outputs

### Input Variables

Input variables serve as parameters for a Terraform module, allowing aspects of the module to be customized without altering the module's source code.

#### Basic Variable Declaration

Variables are declared in a `.tf` file, often named `variables.tf`:

```hcl
variable "region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-west-2"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "enable_monitoring" {
  description = "Whether to enable detailed monitoring"
  type        = bool
  default     = false
}
```

#### Variable Types

Terraform supports the following variable types:
- Primitive types: `string`, `number`, `bool`
- Complex types: `list`, `set`, `map`, `object`, `tuple`

Example of complex types:

```hcl
variable "vpc_cidrs" {
  type = list(string)
  default = ["10.0.0.0/16", "10.1.0.0/16"]
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Owner       = "DevOps Team"
  }
}

variable "server_config" {
  type = object({
    name    = string
    size    = string
    is_public = bool
  })
  default = {
    name    = "web-server"
    size    = "t2.micro"
    is_public = true
  }
}
```

#### Using Variables

Reference variables in your configuration using the `var` keyword:

```hcl
resource "aws_instance" "server" {
  count         = var.instance_count
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.server_config.size
  
  tags = var.tags
}
```

#### Setting Variable Values

There are multiple ways to set variable values:

1. In a `.tfvars` file:
```hcl
# terraform.tfvars
region = "us-east-1"
instance_count = 3
```

2. On the command line:
```bash
terraform apply -var="region=us-east-1" -var="instance_count=3"
```

3. With environment variables:
```bash
export TF_VAR_region=us-east-1
export TF_VAR_instance_count=3
```

### Output Values

Output values expose specific values from your configuration, making them available to the user or to other Terraform configurations.

#### Declaring Outputs

Outputs are defined in a `.tf` file, often named `outputs.tf`:

```hcl
output "instance_ip_addr" {
  description = "The public IP address of the web server"
  value       = aws_instance.server.public_ip
}

output "db_connection_string" {
  description = "The connection string for the database"
  value       = "postgres://${aws_db_instance.db.username}:${aws_db_instance.db.password}@${aws_db_instance.db.endpoint}/mydb"
  sensitive   = true
}
```

The `sensitive` attribute marks outputs that contain sensitive information, which Terraform will hide in the console output.

#### Accessing Outputs

After applying your configuration, view the outputs with:

```bash
terraform output
```

To see the value of a specific output:

```bash
terraform output instance_ip_addr
```

To see sensitive outputs:

```bash
terraform output -json
```

### Hands-on Exercise

Create the following files in your working directory:

**variables.tf**:
```hcl
variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources into"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone to deploy resources into"
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "The name of the VM instance"
  type        = string
  default     = "terraform-instance"
}

variable "machine_type" {
  description = "The machine type for the VM instance"
  type        = string
  default     = "e2-micro"
}
```

**main.tf**:
```hcl
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
}
```

**outputs.tf**:
```hcl
output "instance_name" {
  description = "The name of the instance"
  value       = google_compute_instance.vm_instance.name
}

output "instance_external_ip" {
  description = "The external IP address of the instance"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "instance_self_link" {
  description = "The URI of the instance resource"
  value       = google_compute_instance.vm_instance.self_link
}
```

**terraform.tfvars**:
```hcl
project_id = "your-project-id"
```

Try running:
1. `terraform init` to initialize the working directory
2. `terraform plan` to see what actions Terraform will take
3. `terraform apply` to apply the changes

### Next Steps

In the next lesson, we'll explore State Management and Workspaces, crucial concepts for managing your infrastructure across environments. 