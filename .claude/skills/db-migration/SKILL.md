---
name: db-migration
description: Create and apply database migrations
argument-hint: "[description of schema change]"
disable-model-invocation: true
---

# Database Migration

Create a new migration for: $ARGUMENTS

## Process
1. Read the current schema (e.g., `prisma/schema.prisma` or equivalent)
2. Make the requested schema changes
3. Follow the database rules in `.claude/rules/database.md`
4. Run the migration command (e.g., `npx prisma migrate dev --name <descriptive-name>`)
5. Verify migration applied successfully

## Rules
- NEVER modify existing committed migrations
- Always create a NEW migration
