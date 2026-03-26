---
name: infrastructure-as-code
description: Provisions and manages cloud infrastructure using code — Terraform for cloud resources, Docker Compose for local development, environment promotion (dev → staging → prod), and cost management. Use when setting up cloud infrastructure, moving beyond managed platforms, provisioning databases, configuring CDNs, or managing infrastructure costs. Trigger for "Terraform", "infrastructure setup", "cloud provisioning", "AWS setup", "GCP setup", "scale infrastructure", or "infrastructure as code". Part of the Founder OS engineering suite.
---

# Infrastructure as Code — Founder OS

## When to use IaC vs managed platforms

| Stage | Recommendation |
|-------|---------------|
| Pre-PMF | Use Vercel + Supabase + Railway. Don't do IaC. |
| Post-PMF, <$50K MRR | Stay managed unless compliance requires otherwise |
| Series A or compliance need | Move to Terraform + AWS/GCP |
| Full team, DevOps hire | Full IaC ownership |

**Rule:** Don't manage infrastructure until you have someone whose job it is to manage infrastructure.

---

## Framework 1: Terraform Basics

```hcl
# main.tf — starter AWS setup

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Store state remotely (required for teams)
  backend "s3" {
    bucket = "yourcompany-terraform-state"
    key    = "production/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}

# Variables
variable "aws_region" {
  default = "us-east-1"
}

variable "environment" {
  description = "dev, staging, or production"
}

variable "app_name" {
  default = "yourapp"
}
```

### RDS Database (PostgreSQL)
```hcl
# database.tf
resource "aws_db_instance" "main" {
  identifier           = "${var.app_name}-${var.environment}"
  engine               = "postgres"
  engine_version       = "16.1"
  instance_class       = var.environment == "production" ? "db.t3.medium" : "db.t3.micro"
  allocated_storage    = 20
  max_allocated_storage = 100  # Auto-scale storage

  db_name  = var.app_name
  username = "dbadmin"
  password = var.db_password  # From secrets manager or var

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  backup_retention_period = 7
  deletion_protection     = var.environment == "production"
  skip_final_snapshot     = var.environment != "production"

  tags = local.common_tags
}
```

### ECS (Container deployment)
```hcl
# ecs.tf
resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-${var.environment}"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.app_name}-${var.environment}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.environment == "production" ? 512 : 256
  memory                   = var.environment == "production" ? 1024 : 512

  container_definitions = jsonencode([{
    name  = "app"
    image = "${aws_ecr_repository.app.repository_url}:latest"
    portMappings = [{
      containerPort = 3000
      protocol      = "tcp"
    }]
    environment = [
      { name = "NODE_ENV", value = var.environment }
    ]
    secrets = [
      { name = "DATABASE_URL", valueFrom = aws_secretsmanager_secret.db_url.arn }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/${var.app_name}"
        awslogs-region        = var.aws_region
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}
```

---

## Framework 2: Environment Promotion

```
Development → Staging → Production

Each environment is identical infrastructure, different scale:
- dev: Smallest instances, test data, no backups required
- staging: Mirror of production, production data snapshot weekly
- production: Full scale, backups, deletion protection
```

### Terraform Workspace Pattern
```bash
# Create workspaces
terraform workspace new staging
terraform workspace new production

# Deploy to specific environment
terraform workspace select staging
terraform apply -var="environment=staging"

terraform workspace select production
terraform apply -var="environment=production"
```

---

## Framework 3: Cost Management

### Cost by architecture tier

| Architecture | Monthly cost | Good for |
|-------------|-------------|---------|
| Vercel + Supabase | $0-100 | <$100K ARR |
| Railway + managed DB | $50-300 | $100K-500K ARR |
| AWS ECS + RDS | $200-1000 | $500K+ ARR or compliance |
| Full Kubernetes | $1000+ | Series A+ with DevOps team |

### AWS cost controls
```hcl
# Budget alert
resource "aws_budgets_budget" "monthly" {
  name         = "${var.app_name}-monthly-budget"
  budget_type  = "COST"
  limit_amount = "500"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 80
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = ["founder@yourcompany.com"]
  }
}
```

---

## Framework 4: Docker Compose for Local Dev

```yaml
# docker-compose.yml (complete local stack)
version: '3.9'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.dev
    ports:
      - "3000:3000"
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://user:pass@db:5432/appdb
      - REDIS_URL=redis://redis:6379
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
    command: npm run dev

  db:
    image: postgres:16-alpine
    ports:
      - "5432:5432"
    environment:
      POSTGRES_DB: appdb
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user -d appdb"]
      interval: 5s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

volumes:
  postgres_data:
  redis_data:
```

---

## Integration

- Coordinates with → `devops-engineer` (CI/CD deploys to this infrastructure)
- Coordinates with → `security-hardening` (security groups, IAM policies)
- Coordinates with → `regulatory-compliance` (data residency, encryption at rest)
- Feeds → `database-design` (which database service to use)
