#                    TERRAFORM PROJECT 2
#             Local Provider, Resources & Terraform State

# Objective

The objective of this project is to understand how Terraform creates, manages, updates, tracks, detects changes in, and destroys resources.

A local file is used as the resource so that the complete Terraform lifecycle can be practised without using any cloud platform or incurring any cost.

---

# What is a Terraform Provider?

A Terraform Provider is a plugin that allows Terraform to communicate with an external platform, service, or system.

Terraform itself does not directly know how to create resources in AWS, Azure, Kubernetes, or the local machine.

Providers contain the logic required to manage those resources.

Examples:

```text
AWS Provider
Azure Provider
Kubernetes Provider
Local Provider
```

Architecture:

```text
Terraform
    ↓
Provider
    ↓
External Platform / Service
```

Example:

```text
Terraform
    ↓
AWS Provider
    ↓
AWS API
    ↓
EC2 / VPC / S3
```

For this project:

```text
Terraform
    ↓
Local Provider
    ↓
Local Machine
    ↓
File
```

---

# Local Provider

The Local Provider allows Terraform to manage resources on the local machine.

Provider source:

```hcl
source = "hashicorp/local"
```

Example configuration:

```hcl
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {
}
```

The Local Provider does not require authentication credentials.

---

# What is a Terraform Resource?

A Resource represents an infrastructure object that Terraform creates and manages.

Examples:

```text
EC2 Instance
VPC
Security Group
S3 Bucket
Local File
```

Basic syntax:

```hcl
resource "RESOURCE_TYPE" "RESOURCE_NAME" {
}
```

Example:

```hcl
resource "local_file" "devops_file" {
}
```

Here:

```text
local_file
```

is the resource type.

```text
devops_file
```

is the local Terraform name assigned to that resource.

The complete Terraform address becomes:

```text
local_file.devops_file
```

---

# First Terraform Resource

Configuration:

```hcl
resource "local_file" "devops_file" {
  filename = "${path.module}/devops.txt"
  content  = "Hello from Terraform!"
}
```

Purpose:

Terraform creates and manages a file named:

```text
devops.txt
```

with the specified content.

---

# What is path.module?

```hcl
${path.module}
```

refers to the directory containing the current Terraform module.

Example:

```hcl
filename = "${path.module}/devops.txt"
```

creates the file inside the current Terraform project directory.

---

# Declarative Infrastructure

Terraform is declarative.

This means we describe:

```text
WHAT we want
```

rather than manually specifying every step required to create it.

Example:

```hcl
resource "local_file" "devops_file" {
  filename = "devops.txt"
  content  = "Hello"
}
```

We declare:

```text
I want this file to exist.
```

Terraform determines how to create and manage it.

---

# Desired State

Terraform configuration represents the desired state.

Example:

```text
main.tf

"I want devops.txt
with specific content."
```

Terraform compares the desired state with the existing managed resources and determines what actions are required.

Concept:

```text
Desired State
     ↓
Terraform
     ↓
Current State
     ↓
Required Changes
```

---

# terraform init

Command:

```bash
terraform init
```

Purpose:

Initializes the Terraform working directory.

In this project, Terraform detects:

```hcl
source = "hashicorp/local"
```

and downloads the Local Provider.

Responsibilities:

- Initializes the project
- Downloads provider plugins
- Creates `.terraform`
- Creates or updates `.terraform.lock.hcl`

It does not create the actual resource.

---

# .terraform Directory

The `.terraform` directory contains downloaded providers and Terraform's internal working files.

Example:

```text
.terraform/
└── providers/
```

It is automatically managed by Terraform.

---

# .terraform.lock.hcl

The lock file records selected provider versions.

Purpose:

- Consistent provider versions
- Repeatable Terraform executions
- Stable team environments

It should normally be committed to Git.

---

# terraform fmt

Command:

```bash
terraform fmt
```

Purpose:

Formats Terraform files according to standard HCL formatting conventions.

It improves:

- Readability
- Consistency
- Code reviews

---

# terraform validate

Command:

```bash
terraform validate
```

Purpose:

Checks whether the Terraform configuration is syntactically and structurally valid.

Expected:

```text
Success! The configuration is valid.
```

It does not create infrastructure.

---

# terraform plan

Command:

```bash
terraform plan
```

Purpose:

Shows the changes Terraform intends to make before modifying resources.

Terraform evaluates:

```text
Configuration
      ↓
State
      ↓
Actual Resource
      ↓
Required Actions
```

Example:

```text
Plan: 1 to add, 0 to change, 0 to destroy.
```

Meaning:

```text
1 to add
→ One resource will be created.

0 to change
→ No managed resource requires modification.

0 to destroy
→ Nothing will be removed.
```

`terraform plan` is only a preview.

It does not normally create resources.

---

# terraform apply

Command:

```bash
terraform apply
```

Purpose:

Executes the changes required to make the infrastructure match the Terraform configuration.

Terraform displays the plan and asks for confirmation.

```text
Do you want to perform these actions?

Enter a value:
```

Enter:

```text
yes
```

Example result:

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

---

# Idempotent Behaviour

After successfully applying the configuration, running:

```bash
terraform plan
```

again without changing anything should normally show:

```text
No changes.
Your infrastructure matches the configuration.
```

Terraform does not blindly create duplicate managed resources every time it runs.

It works toward the declared desired state.

---

# terraform.tfstate

After Terraform creates a managed resource, it creates:

```text
terraform.tfstate
```

The state file records information about the resources Terraform manages.

Conceptually:

```text
main.tf
"What I want"

       ↓

Terraform

       ↕

terraform.tfstate
"What Terraform tracks"

       ↓

Actual Resource
```

Terraform state is extremely important because it maps Terraform resource addresses to real managed resources.

---

# Why Terraform State is Important

Terraform needs state to understand:

- Which resources it manages
- Resource attributes
- Relationships between resources
- What has changed
- What needs to be created, modified, or destroyed

Without reliable state information, Terraform cannot safely manage infrastructure.

---

# Important State Rule

Do not manually edit:

```text
terraform.tfstate
```

during normal operations.

Incorrect manual changes can cause Terraform to lose track of resources or propose incorrect actions.

Use Terraform state commands instead.

---

# terraform state list

Command:

```bash
terraform state list
```

Purpose:

Displays all resources currently tracked in Terraform state.

Example:

```text
local_file.devops_file
```

---

# terraform state show

Command:

```bash
terraform state show local_file.devops_file
```

Purpose:

Displays detailed information about a specific resource stored in Terraform state.

This is safer and easier than reading the raw state JSON manually.

---

# Resource Modification

Terraform can modify infrastructure by changing the configuration.

Example:

Original:

```hcl
content = "Hello from Terraform!"
```

Updated:

```hcl
content = "Terraform is managing this file."
```

Then:

```bash
terraform plan
terraform apply
```

Terraform detects that the desired configuration changed and determines the required action.

For some resources or attributes, Terraform may update them in place.

For others, the provider may require replacement.

Always inspect the plan.

---

# Configuration Drift

Configuration drift occurs when a Terraform-managed resource is changed outside Terraform.

Example:

Terraform expects:

```text
Terraform is managing this file.
```

Someone manually changes it to:

```text
Someone changed this manually!
```

Now:

```text
Desired State
      ≠
Actual State
```

This is called drift.

---

# Drift Detection

Running:

```bash
terraform plan
```

allows Terraform to detect differences between the declared configuration and the current managed resource.

Terraform then proposes actions required to restore the desired state.

Concept:

```text
Terraform Configuration
        ↓
Desired State

        ≠

Manual Change
        ↓
Actual State

        ↓

terraform plan

        ↓

Corrective Action
```

---

# Manual Resource Deletion

Suppose someone manually deletes:

```text
devops.txt
```

using:

```bash
rm devops.txt
```

but the Terraform configuration still contains:

```hcl
resource "local_file" "devops_file" {
  ...
}
```

Terraform still expects the resource to exist.

Running:

```bash
terraform plan
```

detects that the managed resource is missing and can propose recreating it.

---

# Real-World Drift Example

Suppose Terraform manages:

```text
Production EC2 Instance
```

Someone manually deletes that EC2 instance from the AWS Console.

Terraform configuration still says:

```text
The EC2 instance should exist.
```

A later Terraform plan can detect that the managed infrastructure no longer matches the desired configuration and propose creating the missing resource again.

---

# Manual Infrastructure Changes

Terraform-managed infrastructure should normally be modified through Terraform configuration rather than manually through cloud consoles.

Manual modifications can cause:

```text
Configuration Drift
```

which makes infrastructure harder to manage consistently.

---

# Configuration Change vs Drift

These are different concepts.

## Configuration Change

You intentionally modify:

```text
main.tf
```

Example:

```text
Desired replicas = 2

changed to

Desired replicas = 3
```

This is intentional infrastructure modification.

---

## Drift

Someone changes the actual resource outside Terraform.

Example:

```text
Terraform says:

3 servers should exist

But someone manually deletes one server.
```

Terraform configuration was not changed.

The real infrastructure changed.

That is drift.

---

# The Three Important Terraform Layers

Terraform management can be understood through three things:

```text
1. Configuration
   main.tf

   What do I want?

          ↓

2. State
   terraform.tfstate

   What resources is Terraform tracking?

          ↓

3. Real Infrastructure

   What actually exists?
```

Terraform evaluates these to determine the actions required.

---

# terraform destroy

Command:

```bash
terraform destroy
```

Purpose:

Destroys resources managed by the current Terraform configuration.

Example:

```text
Plan: 0 to add, 0 to change, 1 to destroy.
```

After confirmation:

```text
Destroy complete! Resources: 1 destroyed.
```

---

# Why Use terraform destroy Instead of Manual Deletion?

Terraform should manage the complete resource lifecycle.

```text
Create
   ↓
Track
   ↓
Modify
   ↓
Destroy
```

If Terraform created a resource, managing its removal through Terraform helps keep the configuration, state, and real infrastructure consistent.

---

# terraform destroy Does Not Delete the Project

Running:

```bash
terraform destroy
```

removes managed infrastructure.

It does not remove:

```text
main.tf
.terraform/
.terraform.lock.hcl
terraform.tfstate
notes.md
```

The Terraform project itself remains.

---

# Complete Terraform Resource Lifecycle

```text
Write main.tf
      ↓
terraform init
      ↓
Provider Downloaded
      ↓
terraform fmt
      ↓
terraform validate
      ↓
terraform plan
      ↓
Preview Changes
      ↓
terraform apply
      ↓
Resource Created
      ↓
terraform.tfstate
      ↓
Resource Tracked
      ↓
Modify Configuration
      ↓
terraform plan
      ↓
Changes Detected
      ↓
terraform apply
      ↓
Resource Updated / Replaced
      ↓
terraform destroy
      ↓
Resource Removed
```

---

# Important Commands

Initialize project:

```bash
terraform init
```

Format configuration:

```bash
terraform fmt
```

Validate configuration:

```bash
terraform validate
```

Preview changes:

```bash
terraform plan
```

Create or modify resources:

```bash
terraform apply
```

List state resources:

```bash
terraform state list
```

Inspect a state resource:

```bash
terraform state show local_file.devops_file
```

Destroy managed resources:

```bash
terraform destroy
```

---

# Key Points for Interview Revision

- Terraform uses Providers to communicate with external platforms.
- A Provider is a plugin that knows how to manage resources on a specific platform.
- A Resource represents an infrastructure object managed by Terraform.
- Terraform is declarative: configuration describes the desired state.
- `terraform init` initializes the project and downloads required providers.
- `terraform plan` previews infrastructure changes.
- `terraform apply` executes the proposed changes.
- `terraform.tfstate` stores information about resources Terraform manages.
- Terraform resource addresses follow patterns such as `local_file.devops_file`.
- `terraform state list` shows resources tracked in state.
- `terraform state show` displays detailed state information for a resource.
- Terraform detects differences between desired and actual infrastructure.
- Changes made outside Terraform can cause configuration drift.
- Manual deletion of a managed resource can be detected and corrected by Terraform.
- Intentional changes to `main.tf` are configuration changes, not drift.
- `terraform destroy` removes Terraform-managed resources.
- Terraform should ideally manage the complete lifecycle of infrastructure resources.
