# {{PROJECT_NAME}}

<!-- TODO: Replace {{PROJECT_NAME}} with your project name -->
<!-- TODO: Write a one-line description of your project -->

## Stack
<!-- TODO: List your tech stack. Examples: -->
<!-- - **Backend**: Node.js / Python / Rust / Go -->
<!-- - **Frontend**: Next.js / React / Vue -->
<!-- - **Database**: PostgreSQL / MongoDB / SQLite -->
<!-- - **ORM**: Prisma / Drizzle / SQLAlchemy -->
<!-- - **Styling**: Tailwind CSS / CSS Modules -->
<!-- - **Package Manager**: npm / pnpm / bun -->
<!-- - **Containerization**: Docker + docker-compose -->

## Session Start
- ALWAYS read @TASKS.md first — it tracks progress across sessions
- Check the Session Log at the bottom of TASKS.md for where we left off
- Update TASKS.md as you complete work (move tasks, append to session log)

## Architecture
<!-- TODO: Describe your high-level architecture in 3-5 bullet points -->
<!-- Example: -->
<!-- - Monolith / Microservices / Monorepo -->
<!-- - Key data flows -->
<!-- - External integrations -->

## Commands
<!-- TODO: Fill in the commands for your project -->
<!-- - Dev server: `npm run dev` -->
<!-- - Build: `npm run build` -->
<!-- - Test: `npm test` -->
<!-- - Lint: `npm run lint` -->
<!-- - Format: `npm run format` -->
<!-- - Docker up: `docker compose up` -->
<!-- - DB migrate: `npx prisma migrate dev` -->

## Project Structure
<!-- TODO: Define your project structure -->
```
project/
├── src/                     # Source code
├── tests/                   # Tests
├── docs/                    # Documentation (if needed)
└── ...
```

## Conventions
- Git: Conventional commits (`feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`)
<!-- TODO: Add your project-specific conventions. Examples: -->
<!-- - TypeScript: Strict mode, no `any` types -->
<!-- - API responses: `{ data, error, meta }` structure -->
<!-- - JSON fields: snake_case or camelCase -->
<!-- - Database: tenant_id for multi-tenancy, UUIDs for PKs, etc. -->

## Off-Limits
- Never hardcode secrets — use environment variables
- Never write to `.env` files
- Never expose internal error details in API responses
<!-- TODO: Add project-specific guardrails -->

## Key Decisions
<!-- TODO: Record architectural decisions (ADRs) as bullet points -->
<!-- Example: -->
<!-- - PostgreSQL over MongoDB: relational data, strong consistency needed -->
<!-- - Next.js App Router: server components, streaming, built-in API routes -->
