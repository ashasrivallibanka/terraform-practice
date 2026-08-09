#                    TERRAFORM PROJECT 3
#                    Variables & Outputs

# Objective

Understand how Terraform variables make configurations reusable and how outputs return useful information after infrastructure is created.

---

# Input Variables

Variables allow us to pass values into Terraform instead of hardcoding them.

Example:

```hcl
variable "environment" {
  type    = string
  default = "dev"
}
```

Reference a variable using:

```hcl
var.environment
```

Benefits:

- Avoid hardcoding
- Reuse the same Terraform code
- Support different environments
- Easier configuration management

---

# variables.tf

Used to declare input variables.

Example:

```hcl
variable "filename" {
  type        = string
  description = "Name of the file"
}
```

---

# terraform.tfvars

Used to provide values for variables.

Example:

```hcl
filename     = "devops.txt"
file_content = "Hello from Terraform"
```

Flow:

```text
variables.tf
     ↓
Declares Variables

terraform.tfvars
     ↓
Provides Values

main.tf
     ↓
Uses Variables
```

---

# Required vs Default Variables

Without a default:

```hcl
variable "filename" {
  type = string
}
```

Terraform requires a value to be provided.

With a default:

```hcl
variable "environment" {
  type    = string
  default = "dev"
}
```

Terraform uses `dev` unless another value overrides it.

---

# Important Variable Types

```text
string  → Text
number  → Numeric value
bool    → true / false
list    → Ordered collection
map     → Key-value collection
```

Examples:

```hcl
type = string
type = number
type = bool
type = list(string)
type = map(string)
```

---

# List

Stores multiple ordered values.

```hcl
servers = [
  "web",
  "app",
  "database"
]
```

Access:

```hcl
var.servers[0]
```

---

# Map

Stores key-value pairs.

```hcl
instance_types = {
  dev  = "t3.micro"
  prod = "t3.large"
}
```

Access:

```hcl
var.instance_types["prod"]
```

---

# Variable Validation

Validation prevents invalid input values.

Example:

```hcl
validation {
  condition     = contains(["dev", "test", "prod"], var.environment)
  error_message = "Environment must be dev, test, or prod."
}
```

---

# Command-Line Variable

A value can also be supplied directly:

```bash
terraform plan -var="environment=prod"
```

For the simple cases practised in this project:

```text
Default Value
     ↓
terraform.tfvars
     ↓
-var
```

The more explicit value can override the earlier one.

---

# Output Values

Outputs return useful information from Terraform.

Example:

```hcl
output "environment" {
  value = var.environment
}
```

For AWS, outputs can return values such as:

```text
EC2 Public IP
Instance ID
Load Balancer DNS
VPC ID
```

View outputs:

```bash
terraform output
```

Specific output:

```bash
terraform output environment
```

---

# Resource Attribute Reference

Syntax:

```text
resource_type.resource_name.attribute
```

Example:

```hcl
local_file.devops_file.filename
```

AWS example:

```hcl
aws_instance.web.public_ip
```

---

# Variables vs Outputs

```text
Variables
   ↓
INPUT to Terraform
   ↓
Terraform Resources
   ↓
Outputs
   ↓
RESULT from Terraform
```

---

# Sensitive Variables

A variable can be marked:

```hcl
sensitive = true
```

This helps hide the value from normal CLI output.

Important:

**Sensitive does not mean the value is automatically encrypted in Terraform state.**

Never commit real passwords, tokens, or cloud credentials to GitHub.

---

# Quick Interview Revision

**What is a Terraform variable?**  
An input variable allows values to be passed into Terraform configuration instead of hardcoding them.

**Why do we use variables?**  
To make Terraform code reusable, configurable, and suitable for different environments.

**What is `variables.tf`?**  
It commonly contains variable declarations.

**What is `terraform.tfvars`?**  
It provides values for input variables and is automatically loaded by Terraform.

**How do you reference a variable?**

```hcl
var.variable_name
```

**What are common variable types?**

```text
string
number
bool
list
map
```

**What is the difference between list and map?**

```text
List → Access by index
Map  → Access by key
```

**What is an output?**  
An output exposes useful information from Terraform-managed infrastructure.

**How do you view outputs?**

```bash
terraform output
```

**Variables vs Outputs?**

```text
Variable = Input to Terraform
Output   = Information returned from Terraform
```

**Why shouldn't secrets be committed in `terraform.tfvars`?**  
Because Git can permanently retain committed credentials in repository history.

---

# Important Commands

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
terraform destroy
```
