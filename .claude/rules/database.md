---
paths:
  - "prisma/**"
  - "**/migrations/**"
  - "**/*.sql"
---

# Database Rules

<!-- TODO: Customize these rules for your project. Delete rules that don't apply. -->

- Never modify a committed/applied migration — create a new one
- All tables have `created_at` (default NOW()) and `updated_at` (trigger)
- Use UUIDs for primary keys (not auto-increment integers)
- Index all foreign keys and columns used in WHERE clauses
- Use `TIMESTAMPTZ` not `TIMESTAMP` for all time columns
- Naming: snake_case for tables and columns, plural table names (e.g., `users`, `posts`)
