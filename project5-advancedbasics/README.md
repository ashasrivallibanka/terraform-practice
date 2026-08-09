#                 TERRAFORM PROJECT 5
#              Advanced Terraform Basics

# count

Used to create multiple instances of the same resource.

```hcl
count = 3
```

Resources are identified using indexes:

```text
resource[0]
resource[1]
resource[2]
```

---

# for_each

Used to create multiple resources using unique keys or values.

```hcl
for_each = toset(["frontend", "backend", "database"])
```

Useful when resources have meaningful names.

---

# count vs for_each

```text
count    → Uses numeric indexes
for_each → Uses unique keys
```

Use `count` for similar repeated resources.

Use `for_each` when each resource has a unique identity.

---

# Locals

Locals are reusable values defined inside Terraform.

```hcl
locals {
  environment = "dev"
}
```

Access:

```hcl
local.environment
```

```text
Variable → External input
Local    → Internal reusable value
```

---

# Data Source

A data source reads information that already exists.

Example:

```hcl
data "aws_ami" "ubuntu" {
}
```

Remember:

```text
Resource    → Creates/manages infrastructure
Data Source → Reads existing information
```

---

# depends_on

Used to explicitly define a dependency between resources.

```hcl
depends_on = [
  local_file.config
]
```

Use it when Terraform cannot automatically identify the dependency.

---

# Conditional Expression

Used to choose a value based on a condition.

```hcl
condition ? true_value : false_value
```

Example:

```hcl
var.environment == "prod" ? "Production" : "Development"
```

---

# Quick Interview Revision

**What is `count`?**  
Creates multiple resource instances using numeric indexes.

**What is `for_each`?**  
Creates multiple resource instances using unique keys.

**`count` vs `for_each`?**  
`count` uses indexes; `for_each` uses unique keys.

**What are locals?**  
Reusable internal values within Terraform configuration.

**Variable vs local?**  
Variable = external input. Local = internal reusable value.

**What is a data source?**  
Used to read information about existing resources/data.

**Resource vs data source?**  
Resource creates/manages; data source reads.

**What is `depends_on`?**  
Explicitly defines a dependency between resources.

**Does Terraform execute code top-to-bottom?**  
No. Terraform uses a dependency graph to determine the execution order.
