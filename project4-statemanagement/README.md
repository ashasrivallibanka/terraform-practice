#                    TERRAFORM PROJECT 4
#                      State Management

# Objective

Understand how Terraform tracks infrastructure using the state file and why remote state and state locking are important in real projects.

---

# What is Terraform State?

Terraform uses a state file called:

```text
terraform.tfstate
```

It stores information about the resources Terraform manages.

Simple flow:

```text
main.tf
What we want
     ↓
Terraform
     ↕
terraform.tfstate
What Terraform tracks
     ↓
Actual Infrastructure
```

---

# Why Does Terraform Need State?

Terraform needs state to know:

- Which resources it manages
- Resource IDs and attributes
- What already exists
- What has changed
- What needs to be created, modified, or destroyed

Example:

```text
Terraform Resource
aws_instance.web
        ↓
State Mapping
        ↓
Actual EC2
i-123456
```

---

# Desired State vs Terraform State vs Actual Infrastructure

```text
main.tf
     ↓
Desired State
What we want

terraform.tfstate
     ↓
Terraform State
What Terraform tracks

Actual Infrastructure
     ↓
What really exists
```

Terraform uses this information to determine required changes.

---

# Important State Commands

List resources tracked by Terraform:

```bash
terraform state list
```

Show details of one resource:

```bash
terraform state show local_file.state_demo
```

Show the current state in readable format:

```bash
terraform show
```

---

# terraform state rm

Command:

```bash
terraform state rm local_file.state_demo
```

This removes the resource from **Terraform state**.

It does NOT normally delete the actual resource.

Example:

```text
Before:

Terraform State → Resource
Actual Resource → Exists

After state rm:

Terraform State → Not Tracked
Actual Resource → Still Exists
```

Terraform simply stops managing that resource.

---

# What Happens if State is Lost?

The actual infrastructure does not automatically disappear.

But Terraform loses its previous mapping to those resources.

```text
Infrastructure
     ↓
Still Exists

State
     ↓
Missing

Terraform
     ↓
No Longer Has Previous Resource Mapping
```

This can cause serious infrastructure-management problems.

Therefore, Terraform state is critical data.

---

# terraform.tfstate.backup

Terraform may create:

```text
terraform.tfstate.backup
```

It contains the previous local state before the latest state update.

---

# Never Manually Edit State

Do not manually modify:

```text
terraform.tfstate
```

Incorrect changes can cause Terraform to lose track of resources or produce incorrect plans.

Use Terraform state commands instead.

---

# Local State

By default, Terraform stores state locally:

```text
Project Directory
      ↓
terraform.tfstate
```

Local state is fine for learning and individual practice.

It is not ideal for teams managing shared infrastructure.

---

# Remote State

In real projects, teams commonly store Terraform state in a shared remote backend.

Example with AWS:

```text
Developer A ──┐
Developer B ──┼──→ Remote State
CI/CD Pipeline┘
```

A common AWS approach is storing remote state in:

```text
Amazon S3
```

Benefits:

- Shared state
- Centralized storage
- Better collaboration
- Easier backup and protection

---

# State Locking

State locking helps prevent multiple Terraform operations from modifying the same state simultaneously.

Example:

```text
Engineer A
    ↓
Gets State Lock
    ↓
terraform apply

Engineer B
    ↓
Must Wait

Engineer A finishes
    ↓
Lock Released
```

This helps prevent conflicting state changes.

---

# State Locking vs .terraform.lock.hcl

These are different.

### State Locking

Prevents concurrent Terraform operations from conflicting over the same state.

### `.terraform.lock.hcl`

Records selected provider dependency versions.

```text
State Locking
→ Protects state during operations

.terraform.lock.hcl
→ Provider dependency/version consistency
```

---

# Should terraform.tfstate Be Pushed to GitHub?

No.

State files may contain:

- Resource IDs
- IP addresses
- Infrastructure details
- Configuration values
- Sensitive information

Typical `.gitignore`:

```gitignore
.terraform/
*.tfstate
*.tfstate.*
terraform.tfvars
```

Normally keep:

```text
.terraform.lock.hcl
```

in Git.

---

# Configuration Drift

Drift happens when Terraform-managed infrastructure is changed outside Terraform.

Example:

```text
Terraform Configuration
      ↓
Server should exist

Someone manually deletes server

      ↓

Actual Infrastructure
doesn't match configuration
```

Running:

```bash
terraform plan
```

can detect such differences and propose corrective actions.

---

# Quick Interview Revision

**What is Terraform state?**

Terraform state stores information about resources Terraform manages and maintains the mapping between Terraform configuration and actual infrastructure.

**What is the default state file?**

```text
terraform.tfstate
```

**Why is state important?**

Terraform uses state to understand what resources it manages and determine what needs to be created, changed, or destroyed.

**What happens if the state file is deleted?**

The actual infrastructure remains, but Terraform loses its previous resource mappings, which can cause management problems.

**What is remote state?**

Remote state stores Terraform state in a shared backend instead of only on one engineer's machine.

**Why use remote state?**

For centralized state management, collaboration, protection, and shared access.

**What is state locking?**

State locking prevents conflicting concurrent Terraform operations against the same state.

**What does `terraform state rm` do?**

It removes a resource from Terraform's state without normally deleting the actual infrastructure.

**Should we manually edit terraform.tfstate?**

No. Terraform state commands should be used instead.

**Should terraform.tfstate be committed to Git?**

Generally no, especially for real infrastructure, because it can contain sensitive infrastructure information.

**Difference between state locking and `.terraform.lock.hcl`?**

State locking protects state from concurrent modifications, while `.terraform.lock.hcl` maintains consistent provider dependency selections.
