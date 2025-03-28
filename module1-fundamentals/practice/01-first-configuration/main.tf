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
