# Module 4 Practice Exercises

Apply the best practices learned in this module to the following scenarios.

## Exercise 1: Code Organization

1.  **Scenario:** You have a growing Terraform project managing a web application with a database and networking components.
2.  **Task:** Propose a directory structure to organize the Terraform code for better maintainability and scalability. Explain the rationale behind your chosen structure.
    *   Consider using modules for reusable components.
    *   Think about separating environments (e.g., dev, staging, prod).

## Exercise 2: Naming Conventions

1.  **Scenario:** Review the following Terraform resource definition:
    ```terraform
    resource "aws_instance" "webserver" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"
      tags = {
        Name = "WebServerInstance"
      }
    }
    ```
2.  **Task:** Refactor the resource definition using a consistent and descriptive naming convention for both the resource name (`webserver`) and the tag (`Name`). Justify your changes based on best practices.

## Exercise 3: Security Best Practices

1.  **Scenario:** Your Terraform configuration needs to handle sensitive data, such as API keys or database passwords.
2.  **Task:** Describe at least two methods for securely managing secrets in Terraform. Avoid hardcoding sensitive values directly in the configuration files. Explain the pros and cons of each method.
    *   Consider using input variables with `.tfvars` files (and `.gitignore`).
    *   Consider using environment variables.
    *   Consider using a secret management tool (like HashiCorp Vault, AWS Secrets Manager, GCP Secret Manager).

## Exercise 4: Version Control Integration

1.  **Scenario:** You are starting a new Terraform project that will be managed by a team.
2.  **Task:** Create a `.gitignore` file suitable for a Terraform project. List the essential files and directories that should typically be excluded from version control and explain why.
    *   Think about state files, plan files, provider plugins, and sensitive variable files.

## Exercise 5: CI/CD Integration (Conceptual)

1.  **Scenario:** You want to automate the process of applying Terraform changes whenever code is pushed to your Git repository's main branch.
2.  **Task:** Outline the key steps involved in setting up a basic CI/CD pipeline for Terraform using a tool like GitHub Actions or GitLab CI/CD. Describe the purpose of each step (e.g., linting, validation, planning, applying).
    *   `terraform fmt -check`
    *   `terraform init`
    *   `terraform validate`
    *   `terraform plan`
    *   `terraform apply` (consider manual approval for production environments) 