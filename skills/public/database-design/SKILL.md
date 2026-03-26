---
name: database-design
description: Designs database schemas, migration strategies, indexing, query optimization, and ORM patterns. Use when a team needs to design a data model, plan database migrations safely, optimize slow queries, choose between SQL and NoSQL, set up multi-tenancy, or implement soft delete patterns. Trigger for "design the database", "data model", "schema", "migration", "indexes", "slow queries", "Prisma", "Drizzle", "multi-tenancy", or "database architecture". Part of the Founder OS suite — the data layer hat.
---

# Database Design — Founder OS

The database schema is the hardest thing to change after launch. Get it right upfront. Every structural change after users have data costs exponentially more than designing it correctly first.

---

## Core Design Principles

1. **Normalise first, denormalise intentionally** — start with clean relational design, add denormalisation only when you have proven query performance problems
2. **Soft delete by default** — never hard-delete user data without a retention policy
3. **Audit columns on every table** — `created_at`, `updated_at`, `deleted_at`
4. **UUID primary keys** — not auto-increment integers (security + distributed systems)
5. **Foreign key constraints in the database** — don't rely on application logic alone

---

## Base Schema Pattern

```sql
-- Every table inherits this structure
CREATE TABLE [table_name] (
  -- Primary key
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Audit columns (always present)
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at    TIMESTAMPTZ,              -- NULL = active, timestamp = soft deleted

  -- Foreign keys (as needed)
  org_id        UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
  created_by    UUID REFERENCES users(id) ON DELETE SET NULL,

  -- Domain columns
  [column]      [type] NOT NULL,
  [column]      [type],                   -- Nullable = truly optional
);

-- Auto-update updated_at on every update
CREATE TRIGGER update_[table]_updated_at
  BEFORE UPDATE ON [table_name]
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
```

---

## Multi-Tenancy Patterns

Choose based on your security and scale requirements:

### Pattern 1: Shared Database, Shared Schema (RLS)
```sql
-- Every table has org_id
-- Row Level Security filters automatically

ALTER TABLE [table] ENABLE ROW LEVEL SECURITY;

CREATE POLICY tenant_isolation ON [table]
  USING (org_id = current_setting('app.current_org_id')::UUID);

-- In application: SET app.current_org_id = '[org_id]';
```
**Best for**: Startups, cost-sensitive, simpler operations

### Pattern 2: Shared Database, Separate Schemas
```sql
-- Each tenant gets their own schema
CREATE SCHEMA tenant_[org_id];
CREATE TABLE tenant_[org_id].users (...);
```
**Best for**: Mid-market, moderate isolation needs

### Pattern 3: Separate Databases
Each tenant gets their own database instance.
**Best for**: Enterprise, high compliance (HIPAA, financial), high-value contracts

---

## Common Schema Patterns

### Users & Authentication
```sql
CREATE TABLE users (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email         TEXT UNIQUE NOT NULL,
  email_verified BOOLEAN NOT NULL DEFAULT false,
  name          TEXT,
  avatar_url    TEXT,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at    TIMESTAMPTZ
);

CREATE TABLE user_sessions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token_hash    TEXT NOT NULL UNIQUE,   -- Never store raw tokens
  expires_at    TIMESTAMPTZ NOT NULL,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_used_at  TIMESTAMPTZ
);

CREATE INDEX idx_sessions_user_id ON user_sessions(user_id);
CREATE INDEX idx_sessions_expires ON user_sessions(expires_at);
```

### Organizations (Multi-tenant B2B)
```sql
CREATE TABLE organizations (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name          TEXT NOT NULL,
  slug          TEXT UNIQUE NOT NULL,   -- For URLs: acme-corp
  plan          TEXT NOT NULL DEFAULT 'free',
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE org_members (
  org_id        UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role          TEXT NOT NULL DEFAULT 'member',  -- owner, admin, member, viewer
  invited_by    UUID REFERENCES users(id),
  joined_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (org_id, user_id)
);
```

### Audit Log (For Compliance)
```sql
CREATE TABLE audit_logs (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  org_id        UUID REFERENCES organizations(id),
  user_id       UUID REFERENCES users(id),
  action        TEXT NOT NULL,          -- "user.created", "billing.updated"
  resource_type TEXT NOT NULL,          -- "user", "project", "payment"
  resource_id   UUID,
  old_value     JSONB,
  new_value     JSONB,
  ip_address    INET,
  user_agent    TEXT,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Partition by month for performance at scale
-- CREATE TABLE audit_logs_2025_03 PARTITION OF audit_logs
--   FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

CREATE INDEX idx_audit_org ON audit_logs(org_id, created_at DESC);
CREATE INDEX idx_audit_user ON audit_logs(user_id, created_at DESC);
```

---

## Indexing Strategy

```sql
-- Index every foreign key (Postgres doesn't do this automatically)
CREATE INDEX idx_[table]_[fk_column] ON [table]([fk_column]);

-- Index columns used in WHERE clauses frequently
CREATE INDEX idx_[table]_[column] ON [table]([column]);

-- Partial indexes for soft delete (most queries filter deleted_at IS NULL)
CREATE INDEX idx_[table]_active ON [table](id) WHERE deleted_at IS NULL;

-- Composite index for common query patterns
-- "Find all active posts by user, ordered by date"
CREATE INDEX idx_posts_user_date ON posts(user_id, created_at DESC)
  WHERE deleted_at IS NULL;

-- Full-text search
CREATE INDEX idx_[table]_search ON [table] USING GIN(
  to_tsvector('english', coalesce(title, '') || ' ' || coalesce(description, ''))
);
```

### Index Audit Query
```sql
-- Find missing foreign key indexes
SELECT tc.table_name, kcu.column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
  ON tc.constraint_name = kcu.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND NOT EXISTS (
    SELECT 1 FROM pg_indexes
    WHERE tablename = tc.table_name
    AND indexdef LIKE '%' || kcu.column_name || '%'
  );
```

---

## Migration Safety Rules

### Safe Migration Pattern (Zero-Downtime)

**Never run migrations that lock tables on production during peak hours.**

```
Adding a column (safe):
  → ALTER TABLE ... ADD COLUMN (instant, uses default)

Adding NOT NULL column (unsafe → safe pattern):
  Step 1: ADD COLUMN nullable
  Step 2: Backfill data: UPDATE table SET col = default_val
  Step 3: ALTER COLUMN SET NOT NULL
  Step 4: Deploy code using the column

Renaming a column (never directly):
  Step 1: ADD COLUMN new_name
  Step 2: Sync writes to both columns
  Step 3: Backfill old → new
  Step 4: Migrate reads to new column
  Step 5: Drop old column (weeks later)

Dropping a column:
  Step 1: Deploy code that no longer reads/writes it
  Step 2: Wait 1 deploy cycle
  Step 3: DROP COLUMN (now safe)
```

---

## ORM Patterns

### Prisma Schema Example
```prisma
model User {
  id            String    @id @default(uuid()) @db.Uuid
  email         String    @unique
  name          String?
  createdAt     DateTime  @default(now())
  updatedAt     DateTime  @updatedAt
  deletedAt     DateTime?

  sessions      Session[]
  memberships   OrgMember[]

  @@index([email])
  @@map("users")
}

model Organization {
  id        String    @id @default(uuid()) @db.Uuid
  name      String
  slug      String    @unique
  plan      String    @default("free")
  createdAt DateTime  @default(now())
  updatedAt DateTime  @updatedAt

  members   OrgMember[]

  @@map("organizations")
}
```

### Query Optimization Patterns
```typescript
// ✗ N+1 problem — runs 1 + N queries
const users = await prisma.user.findMany();
for (const user of users) {
  const posts = await prisma.post.findMany({ where: { userId: user.id } });
}

// ✓ Include — runs 1 query with JOIN
const users = await prisma.user.findMany({
  include: { posts: true },
});

// ✓ Select only needed fields — reduces data transfer
const users = await prisma.user.findMany({
  select: { id: true, email: true, name: true },
  where: { deletedAt: null },
  take: 20,
  skip: page * 20,
  orderBy: { createdAt: 'desc' },
});
```

---

## SQL vs NoSQL Decision

| Criteria | Choose SQL (Postgres) | Choose NoSQL (MongoDB/DynamoDB) |
|----------|----------------------|--------------------------------|
| Data shape | Well-defined, relational | Flexible, document-based |
| Queries | Complex JOINs needed | Simple key-value or document |
| Consistency | ACID required | Eventual consistency OK |
| Scale | Vertical first, then read replicas | Horizontal from day one |
| Compliance | Audit trails, HIPAA, finance | Less regulated |
| Team | General SQL knowledge | NoSQL expertise available |

**Default choice**: PostgreSQL for 95% of startups. It handles everything until you're at a scale most startups never reach.

---

## Integration with Founder OS

- **Designed by** → `business-analyst` (data model from requirements)
- **Implemented by** → `backend-dev` (writes the actual schema + migrations)
- **Audited by** → `security-auditor` (PII handling, encryption at rest, audit logs)
- **Deployed by** → `devops-engineer` (migration runbooks, zero-downtime deploys)
- **Informs** → `api-design` (what data is available to expose)
