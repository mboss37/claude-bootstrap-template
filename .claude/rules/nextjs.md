---
paths:
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.js"
  - "**/*.jsx"
---

# TypeScript / Frontend Rules

<!-- TODO: Customize these rules for your project. Delete rules that don't apply. -->

- Use App Router (not Pages Router) if using Next.js
- Server Components by default — only add `"use client"` when component needs interactivity
- TypeScript strict mode — no `any`, no `@ts-ignore`
- Validate all API inputs with Zod schemas
- All API responses follow: `{ data: T | null, error: { code: string, message: string } | null, meta?: object }`
- Use `next/image` for images, `next/font` for fonts
- Environment variables: `NEXT_PUBLIC_` prefix for client-side only
