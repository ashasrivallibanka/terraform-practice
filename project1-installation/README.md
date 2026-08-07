# ====================================================================
#                    TERRAFORM PROJECT 1
#              Installation & Terraform Fundamentals
# ====================================================================

# Objective

The objective of this project is to install Terraform, understand the concept of Infrastructure as Code (IaC), learn the Terraform workflow, and prepare the local environment for future infrastructure automation.

---

# What is Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp.

It allows infrastructure to be defined, provisioned, modified, and destroyed using configuration files instead of manually creating resources through a cloud provider's console.

Terraform uses **HashiCorp Configuration Language (HCL)** to describe infrastructure.

---

# What is Infrastructure as Code (IaC)?

Infrastructure as Code (IaC) is the practice of managing and provisioning infrastructure through code instead of performing manual configuration.

Traditional Approach

```text
Login to Cloud Console
        ↓
Create Resources Manually
        ↓
Configure Networking
        ↓
Launch Infrastructure
```

Infrastructure as Code

```text
Terraform Configuration
        ↓
terraform apply
        ↓
Infrastructure Created Automatically
```

### Benefits of IaC

- Automation
- Consistency
- Repeatability
- Version Control
- Faster Provisioning
- Reduced Human Errors

---

# Why Terraform?

Terraform helps automate infrastructure creation across multiple cloud providers and platforms.

It enables infrastructure to be:

- Reproducible
- Scalable
- Version Controlled
- Easily Modified
- Easy to Review
- Easy to Share Across Teams

---

# Real-World Example

Suppose a company needs to create:

- 100 EC2 Instances
- 10 Security Groups
- Multiple VPCs
- Load Balancers
- IAM Roles

Creating these resources manually is time-consuming and prone to mistakes.

Using Terraform, the complete infrastructure is described once in code and can be recreated whenever required.

---

# Terraform vs Docker vs Kubernetes

| Tool | Responsibility |
|-------|----------------|
| Terraform | Creates and manages infrastructure |
| Docker | Packages applications into containers |
| Kubernetes | Deploys and manages containers |

Relationship

```text
Terraform
      ↓
Creates Infrastructure
      ↓
Docker
      ↓
Packages Applications
      ↓
Kubernetes
      ↓
Runs & Manages Containers
```

---

# Terraform Project Structure

```text
terraform-practice/
│
└── project-1-installation/
    ├── main.tf
    ├── notes.md
    └── README.md
```

---

# main.tf

`main.tf` is the primary Terraform configuration file.

Example

```hcl
terraform {
  required_version = ">= 1.0"
}
```

Purpose

- Specifies the minimum Terraform version required.
- Ensures compatibility across environments.

---

# Why Install Terraform from the Official Repository?

Terraform was installed using HashiCorp's official APT repository instead of Ubuntu's default repository.

Reasons

- Latest stable version
- Official support
- Verified packages
- Regular updates

---

# Required Packages

### curl

Downloads files from the internet.

### gnupg

Verifies package authenticity using digital signatures.

### software-properties-common

Allows Ubuntu to add external software repositories.

---

# HashiCorp GPG Key

The GPG key verifies that Terraform packages are officially signed by HashiCorp.

Purpose

- Prevents package tampering.
- Ensures package authenticity.
- Improves security.

---

# Terraform Workflow

Every Terraform project follows the same workflow.

```text
Write Configuration
        ↓
terraform init
        ↓
terraform validate
        ↓
terraform fmt
        ↓
terraform plan
        ↓
terraform apply
        ↓
Infrastructure Created
        ↓
terraform destroy
        ↓
Infrastructure Removed
```

---

# terraform init

```bash
terraform init
```

Purpose

Initializes the Terraform working directory.

Responsibilities

- Downloads required providers
- Creates `.terraform` directory
- Generates `.terraform.lock.hcl`
- Prepares the working directory

**Important**

`terraform init` does **NOT** create infrastructure.

---

# .terraform Directory

Created automatically during initialization.

Stores

- Downloaded providers
- Provider plugins
- Internal Terraform metadata

Comparable to

- `node_modules` (Node.js)
- `.venv` (Python)

---

# .terraform.lock.hcl

Purpose

Locks provider versions.

Benefits

- Consistent provider versions
- Same environment across all developers
- Predictable infrastructure deployments

---

# terraform validate

```bash
terraform validate
```

Purpose

Checks whether the Terraform configuration is syntactically valid.

It does not provision or modify infrastructure.

Expected Output

```text
Success! The configuration is valid.
```

---

# terraform fmt

```bash
terraform fmt
```

Purpose

Formats Terraform configuration according to the official Terraform style guide.

Benefits

- Consistent formatting
- Improved readability
- Easier code reviews
- Better collaboration

---

# Commands Used

```bash
cat /etc/os-release

sudo apt update

sudo apt install -y curl gnupg software-properties-common

curl -fsSL https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt install terraform

terraform version

terraform init

terraform validate

terraform fmt
```

---

# Key Points for Interview Revision

- Terraform is an Infrastructure as Code (IaC) tool developed by HashiCorp.
- Terraform uses HCL (HashiCorp Configuration Language).
- Infrastructure can be provisioned and managed using code.
- `main.tf` is the primary Terraform configuration file.
- `terraform init` initializes the working directory.
- `.terraform` stores provider plugins and Terraform metadata.
- `.terraform.lock.hcl` locks provider versions.
- `terraform validate` checks configuration syntax.
- `terraform fmt` formats Terraform configuration.
- Terraform follows the lifecycle: **init → validate → fmt → plan → apply → destroy**.
