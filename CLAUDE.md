# {{PROJECT_NAME}}

<!-- TODO: Replace {{PROJECT_NAME}} with your project name -->
<!-- TODO: Write a one-line description of your project -->

<!--
  FIRST: Install the ECC plugin for agents, skills, hooks, and rules:
  /plugin marketplace add affaan-m/everything-claude-code
  /plugin install everything-claude-code@everything-claude-code
  Then install rules: git clone https://github.com/affaan-m/everything-claude-code.git /tmp/ecc
  cd /tmp/ecc && ./install.sh <language>  (typescript | python | golang | swift)
-->

## Stack
<!-- TODO: Define your tech stack. Example: -->
<!-- - **Framework**: Next.js 15 / FastAPI / Go stdlib / Rails 8 -->
<!-- - **UI**: shadcn/ui + Tailwind / HTMX / Hotwire -->
<!-- - **Database**: Supabase / PostgreSQL / SQLite / MongoDB -->
<!-- - **Auth**: Supabase Auth / NextAuth / JWT / Devise -->
<!-- - **ORM**: Prisma / Drizzle / SQLAlchemy / supabase-js -->
<!-- - **Package Manager**: pnpm / npm / uv / go modules / bundler -->
<!-- - **Language**: TypeScript / Python / Go / Ruby -->

## Session Start
- ALWAYS read @TASKS.md first — it tracks progress across sessions
- Check the Session Log at the bottom of TASKS.md for where we left off
- Update TASKS.md as you complete work (move tasks, append to session log)

## Architecture
<!-- TODO: Describe your high-level architecture in 3-5 bullet points -->
<!-- Example: -->
<!-- - Full-stack monorepo — Next.js handles frontend + API -->
<!-- - Supabase for auth, database, storage, and realtime -->
<!-- - Server Components by default; Client Components only for interactivity -->
<!-- - RLS policies enforce authorization at the database layer -->

## Commands
<!-- TODO: Fill in the commands for your project -->
<!-- - Dev server: `pnpm dev` -->
<!-- - Build: `pnpm build` -->
<!-- - Test: `pnpm test` -->
<!-- - Lint: `pnpm lint` -->
<!-- - Format: `pnpm format` -->
<!-- - Type check: `pnpm tsc --noEmit` -->
<!-- - DB migrate: `pnpm supabase db push` -->

## Project Structure
<!-- TODO: Define your project structure -->
```
├── src/                     # Source code
├── tests/                   # Tests
├── docs/                    # Documentation (if needed)
└── ...
```

## Conventions
- Git: Conventional commits (`feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`)
<!-- TODO: Add your project-specific conventions. Examples: -->
<!-- - TypeScript: Strict mode, no `any` types -->
<!-- - Components: Named exports, one component per file -->
<!-- - API responses: `{ data, error }` shape -->
<!-- - Database: UUIDs for PKs, snake_case columns, created_at/updated_at -->
<!-- - Imports: Use `@/` path alias -->

## Workflow (ECC Skills)
- New feature: `/plan` first, then `/tdd` to implement
- After writing code: `/code-review` and `/security-scan` before committing
- Verification: `/verify` runs build + lint + tests in one command
- End of session: update TASKS.md with progress
- Extract patterns: `/learn-eval` to save reusable patterns from session

## Off-Limits
- Never hardcode secrets — use environment variables
- Never write to `.env` files
- Never expose internal error details in API responses
<!-- TODO: Add project-specific guardrails. Examples: -->
<!-- - Never bypass RLS — all client queries go through policies -->
<!-- - Never use service role key in client-side code -->
<!-- - Never edit files in `components/ui/` — use CLI to update -->

## Key Decisions
<!-- TODO: Record architectural decisions as you make them -->
<!-- Example: -->
<!-- - Chose pnpm over npm: faster installs, strict dependency resolution -->
<!-- - Supabase over custom auth: managed infra, built-in RLS, realtime -->
