#                    TERRAFORM PROJECT 2
#              Local Provider & Resource Lifecycle

# Objective

Understand how Terraform creates, tracks, modifies, detects changes in, and destroys a resource using the Local Provider.

---

# Terraform Provider

A Provider is a plugin that allows Terraform to communicate with a platform or service.

Examples:

```text
AWS Provider
Azure Provider
Kubernetes Provider
Local Provider
```

For this project:

```text
Terraform
   ↓
Local Provider
   ↓
Local File
```

---

# Terraform Resource

A Resource is an infrastructure object managed by Terraform.

Example:

```hcl
resource "local_file" "devops_file" {
  filename = "${path.module}/devops.txt"
  content  = "Hello from Terraform!"
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

is the Terraform resource name.

Resource address:

```text
local_file.devops_file
```

---

# Terraform Workflow

```text
Write Configuration
        ↓
terraform init
        ↓
terraform plan
        ↓
terraform apply
        ↓
Resource Created
        ↓
Terraform State
        ↓
terraform destroy
```

---

# terraform init

```bash
terraform init
```

Initializes the Terraform project and downloads required providers.

It does not create infrastructure.

---

# terraform plan

```bash
terraform plan
```

Shows what Terraform intends to:

- Create
- Modify
- Destroy

Example:

```text
Plan: 1 to add, 0 to change, 0 to destroy.
```

`terraform plan` is only a preview.

---

# terraform apply

```bash
terraform apply
```

Executes the changes defined in the Terraform configuration.

Example:

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

---

# Terraform State

Terraform creates:

```text
terraform.tfstate
```

The state file stores information about resources Terraform manages.

Concept:

```text
main.tf
Desired State
      ↓
Terraform
      ↕
terraform.tfstate
      ↓
Actual Resource
```

Do not manually edit the state file.

---

# State Commands

List tracked resources:

```bash
terraform state list
```

Inspect a resource:

```bash
terraform state show local_file.devops_file
```

---

# Desired State

Terraform configuration represents what infrastructure should look like.

Example:

```text
main.tf says:
devops.txt should exist
```

Terraform compares this desired state with the actual resource and determines what changes are required.

---

# Configuration Drift

Drift happens when a Terraform-managed resource is changed manually outside Terraform.

Example:

```text
Terraform expects:
Hello from Terraform

Someone manually changes it:
Changed manually
```

Now:

```text
Desired State ≠ Actual State
```

Running:

```bash
terraform plan
```

detects the difference.

---

# Manual Resource Deletion

If someone manually deletes a Terraform-managed resource but the configuration still says it should exist, Terraform can detect that it is missing.

Example:

```bash
rm devops.txt
terraform plan
```

Terraform can plan to recreate the resource.

---

# Configuration Change vs Drift

## Configuration Change

You intentionally modify:

```text
main.tf
```

This is expected.

## Drift

Someone changes the real infrastructure outside Terraform without changing the Terraform configuration.

---

# terraform destroy

```bash
terraform destroy
```

Removes resources managed by Terraform.

Example:

```text
Plan: 0 to add, 0 to change, 1 to destroy.
```

It removes infrastructure, not the Terraform project files.

---

# Important Commands

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform state list
terraform state show local_file.devops_file
terraform destroy
```

---

# Key Interview Points

- Provider connects Terraform to a platform.
- Resource represents infrastructure managed by Terraform.
- Terraform is declarative and works toward a desired state.
- `terraform plan` previews changes.
- `terraform apply` performs changes.
- `terraform.tfstate` tracks managed resources.
- Drift occurs when infrastructure changes outside Terraform.
- Terraform can detect missing or modified resources.
- `terraform destroy` removes managed infrastructure.
