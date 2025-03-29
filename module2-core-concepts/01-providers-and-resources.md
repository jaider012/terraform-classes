# Module 2: Terraform Core Concepts

## Lesson 1: Providers and Resources

### What are Terraform Providers?

Providers are plugins that Terraform uses to interact with cloud providers, SaaS providers, and other APIs. They serve as the interface between Terraform and the service you want to manage. Providers define and manage resources, which represent infrastructure objects.

Examples of providers include:
- AWS
- Google Cloud
- Microsoft Azure
- Kubernetes
- GitHub
- Docker

### Provider Configuration

Here's how to configure a basic provider:

```hcl
provider "aws" {
  region = "us-west-2"
  profile = "default"
}
```

When you run `terraform init`, Terraform downloads the necessary provider plugins based on your configuration.

### What are Resources?

Resources are the most important element in the Terraform language. Each resource block describes one or more infrastructure objects, such as:
- Virtual networks
- Compute instances
- DNS records
- Identity and access management (IAM) roles

### Resource Syntax

A resource block declares a resource of a given type with a local name:

```hcl
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  tags = {
    Name = "Web Server"
  }
}
```

In this example:
- `aws_instance` is the resource type
- `web_server` is the local name
- The configuration inside the curly braces consists of arguments specific to that resource

### Resource Dependencies

Resources often depend on other resources. Terraform automatically determines these dependencies and creates resources in the correct order.

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "primary" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}
```

In this example, the subnet depends on the VPC because it references `aws_vpc.main.id`. Terraform ensures the VPC is created before attempting to create the subnet.

### Hands-on Exercise

Create a file named `main.tf` with the following content:

```hcl
# Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Create a Google Compute Engine instance
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

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

Try running:
1. `terraform init` to initialize the working directory
2. `terraform plan` to see what actions Terraform will take
3. `terraform apply` to apply the changes (skip this if you don't want to create real resources)

### Next Steps

In the next lesson, we'll explore Variables and Outputs, which help make your Terraform configurations more flexible and reusable. 