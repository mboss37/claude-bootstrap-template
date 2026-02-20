# Claude Code Bootstrap Template

A ready-to-use project template with Claude Code best practices pre-configured. Clone this repo to skip the setup grind and start any new project with agents, rules, hooks, skills, MCP servers, and permissions already wired up.

Built following best practices from the [Claude Code Ultimate Guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide) by Florian Bruniaux — a comprehensive, open-source reference covering Claude Code from beginner to power user. The full guide is available at [cc.bruniaux.com](https://cc.bruniaux.com/).

---

## Table of Contents

- [Quick Start](#quick-start)
- [What's Inside](#whats-inside)
- [Feature Deep Dive](#feature-deep-dive)
  - [CLAUDE.md — Project Memory](#claudemd--project-memory)
  - [TASKS.md — Session-Persistent Task Tracker](#tasksmd--session-persistent-task-tracker)
  - [Agents — Specialized Sub-Agents](#agents--specialized-sub-agents)
  - [Rules — Path-Scoped Conventions](#rules--path-scoped-conventions)
  - [Skills — Slash Command Workflows](#skills--slash-command-workflows)
  - [Hooks — Event-Driven Automation](#hooks--event-driven-automation)
  - [Settings & Permissions](#settings--permissions)
  - [MCP Servers — External Tool Integrations](#mcp-servers--external-tool-integrations)
- [Customizing the Template](#customizing-the-template)
- [License](#license)

---

## Quick Start

```bash
# 1. Clone the template
git clone https://github.com/mboss37/claude-bootstrap-template.git my-project
cd my-project

# 2. Reset git history
rm -rf .git && git init

# 3. Start Claude and let it do the rest
claude
```

Then tell Claude:

> "This project is a [describe your project]. My stack is [your stack]. Reconfigure CLAUDE.md, TASKS.md, rules, agents, skills, and settings to match."

**Claude is the best tool for reconfiguring this template.** It understands all the config formats, knows what each file does, and can rewrite everything in seconds — far faster and more consistent than editing files by hand. Just describe your project and stack, and let it adapt the template for you.

---

## What's Inside

```
├── CLAUDE.md                        # Project memory — loaded every session
├── TASKS.md                         # Sprint tracker — read at session start
├── .claude/
│   ├── settings.json                # Permissions, hooks, denied patterns
│   ├── settings.local.json          # Local overrides (gitignored, create your own)
│   ├── agents/
│   │   ├── code-reviewer.md         # Code review sub-agent
│   │   └── debugger.md              # Bug diagnosis sub-agent
│   ├── hooks/
│   │   ├── auto-format.sh           # Auto-formats files after edits
│   │   ├── security-check.sh        # Blocks dangerous commands
│   │   └── notify.sh                # macOS notification on attention needed
│   ├── rules/
│   │   ├── database.md              # DB conventions (path-scoped to migrations/SQL)
│   │   └── nextjs.md                # TypeScript/frontend conventions (path-scoped to .ts/.tsx)
│   └── skills/
│       ├── db-migration/SKILL.md    # /db-migration slash command
│       ├── deploy/SKILL.md          # /deploy slash command
│       └── wrap-up/SKILL.md         # /wrap-up session summary
├── .mcp.json                        # MCP server configs
└── .gitignore                       # Sensible defaults
```

---

## Feature Deep Dive

### CLAUDE.md — Project Memory

**What it is.** A Markdown file automatically loaded into Claude's context at the start of every session. It's the single most important file in any Claude Code project — your persistent instruction set that eliminates re-explaining your stack, conventions, and architecture every time you start a new conversation.

**Why it matters.** Without CLAUDE.md, every session starts from zero. With it, Claude immediately knows your stack, how your project is structured, what commands to run, what conventions to follow, and what's off-limits. This compounds over time — the more you invest in CLAUDE.md, the better Claude performs across every session.

**What's in the template.** A structured skeleton with sections for:
- **Stack** — your tech choices
- **Session Start** — what Claude should do first (read TASKS.md)
- **Architecture** — high-level system design
- **Commands** — build, test, lint, deploy commands
- **Project Structure** — directory layout
- **Conventions** — coding standards and patterns
- **Off-Limits** — things Claude must never do
- **Key Decisions** — architectural decision records (ADRs)

Each section has `<!-- TODO -->` comments guiding you on what to fill in.

**Scope levels.** Claude Code supports three memory scopes:
| Location | Scope | Committed to git? |
|---|---|---|
| `~/.claude/CLAUDE.md` | Global (all projects) | No |
| `./CLAUDE.md` | Project (shared with team) | Yes |
| `./.claude/CLAUDE.md` | Personal (local overrides) | No |

---

### TASKS.md — Session-Persistent Task Tracker

**What it is.** A lightweight sprint/task tracker that Claude reads at the start of every session. It provides continuity across sessions — Claude knows what was done, what's in progress, and what's next without you having to re-explain.

**Why it matters.** Claude Code sessions are ephemeral. When context is cleared or a session ends, everything is lost unless it's persisted somewhere. TASKS.md bridges this gap. The session log at the bottom gives Claude a 3-line summary of what happened last time, so it can pick up exactly where things left off.

**Built-in rules:**
- Only show current + next sprint (keeps the file short)
- Completed sprints collapse to a single summary line
- Session log: max 3 lines per session, keep only the last 3
- Target: under 80 lines total

---

### Agents — Specialized Sub-Agents

**What they are.** Agents are specialized AI personas that Claude can delegate work to. Each agent has a defined name, model, toolset, and behavioral instructions. They run as autonomous sub-processes — Claude spawns them for specific tasks, they do their work, and return results.

**Why they matter.** Instead of Claude being a generalist for everything, agents let you create focused specialists. A code reviewer only has access to read tools (can't accidentally edit). A debugger follows a strict diagnosis workflow. This separation of concerns produces more consistent, higher-quality output and protects against accidental side effects.

**How they work.** Agents are Markdown files in `.claude/agents/` with YAML frontmatter:

```yaml
---
name: code-reviewer          # How you reference it
description: Reviews code...  # When Claude should use it
model: opus                   # Which model (opus, sonnet, haiku)
tools:                        # Allowed tools (scoped access)
  - Read
  - Grep
  - Glob
  - Bash
---

# Instructions for the agent below...
```

**Included agents:**

| Agent | Model | Purpose | Tools |
|---|---|---|---|
| `code-reviewer` | opus | Security-first code review with structured JSON output (critical/warnings/suggestions) | Read, Grep, Glob, Bash |
| `debugger` | sonnet | Systematic bug diagnosis: read error → identify origin → check recent changes → form hypothesis → verify → propose fix | Read, Grep, Glob, Bash |

**Model selection matters.** Use `opus` for tasks requiring deep reasoning (architecture, security review). Use `sonnet` for faster tasks where speed matters more than depth (debugging, test running). Use `haiku` for simple, high-volume tasks.

---

### Rules — Path-Scoped Conventions

**What they are.** Rules are Markdown files in `.claude/rules/` that are automatically loaded when Claude works on files matching specific glob patterns. Unlike CLAUDE.md (which is always loaded), rules only activate when relevant — keeping context lean.

**Why they matter.** In a polyglot project, you don't want database conventions cluttering Claude's context when it's editing TypeScript. Path-scoped rules solve this: database rules activate only when touching migration files, frontend rules only when editing `.ts`/`.tsx`, etc. This is both more efficient (less token waste) and more precise (no conflicting conventions).

**How they work.** Each rule file has YAML frontmatter with `paths` globs:

```yaml
---
paths:
  - "**/*.ts"
  - "**/*.tsx"
---

# TypeScript Rules
- Use strict mode, no `any` types
- Server Components by default
- Validate API inputs with Zod
```

**Included rules:**

| Rule | Activates on | Key conventions |
|---|---|---|
| `database.md` | `prisma/**`, `**/migrations/**`, `**/*.sql` | Never modify committed migrations, UUIDs for PKs, TIMESTAMPTZ, snake_case naming |
| `nextjs.md` | `**/*.ts`, `**/*.tsx`, `**/*.js`, `**/*.jsx` | Strict TS, App Router, server components by default, Zod validation |

---

### Skills — Slash Command Workflows

**What they are.** Skills are reusable, multi-step workflow templates that you invoke as slash commands (e.g., `/deploy`, `/db-migration`). They encode repeatable procedures so Claude executes them the same way every time, without you having to re-explain the steps.

**Why they matter.** Complex workflows like "create a migration, follow naming conventions, run it, verify it worked" involve many steps and project-specific knowledge. Skills capture this once and make it a one-liner. They're especially valuable for onboarding — new team members get consistent workflows from day one.

**How they work.** Each skill is a `SKILL.md` file inside `.claude/skills/<skill-name>/`:

```yaml
---
name: deploy
description: Build and deploy services
argument-hint: "[target: local|staging|production]"
disable-model-invocation: true
---

# Deploy
Deploy target: $ARGUMENTS (default: local)

## Steps
1. Run pre-deploy checks...
2. Build...
3. Deploy...
```

`$ARGUMENTS` is replaced with whatever the user passes after the command name.

**Included skills:**

| Skill | Command | What it does |
|---|---|---|
| `db-migration` | `/db-migration <description>` | Reads current schema, applies changes, runs migration, verifies |
| `deploy` | `/deploy <target>` | Pre-flight checks, build, deploy, health verification |
| `wrap-up` | `/wrap-up` | Moves completed tasks in TASKS.md, writes session log entry, shows summary |

---

### Hooks — Event-Driven Automation

**What they are.** Hooks are shell scripts that run automatically in response to Claude Code lifecycle events. They execute before or after tool calls, giving you zero-effort guardrails — formatting, security checks, and notifications that happen without manual intervention.

**Why they matter.** Hooks are the automated safety net. They catch dangerous commands before they execute, format code the instant it's written, and ping you when Claude needs input. You don't have to remember to run prettier or worry about Claude running `DROP TABLE` — hooks handle it silently in the background.

**Hook lifecycle events:**

| Event | When it fires | Use case |
|---|---|---|
| `PreToolUse` | Before a tool executes | Block dangerous commands, validate inputs |
| `PostToolUse` | After a tool completes | Auto-format, lint, log changes |
| `Notification` | When Claude needs user attention | Desktop notifications, sounds |

Hooks are configured in `settings.json` and point to scripts in `.claude/hooks/`:

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{ "type": "command", "command": ".claude/hooks/security-check.sh" }]
    }]
  }
}
```

**Included hooks:**

| Hook | Event | What it does |
|---|---|---|
| `security-check.sh` | PreToolUse (Bash) | Blocks `rm -rf /`, `DROP TABLE`, `curl\|bash`, `sudo rm`, `TRUNCATE`, `git push --force`, `git reset --hard`, `chmod 777`, and more |
| `auto-format.sh` | PostToolUse (Write/Edit) | Runs `prettier` on `.ts/.tsx/.js/.jsx/.json`, `pg_format` on `.sql` |
| `notify.sh` | Notification | macOS desktop notification + system sound (macOS only — replace with `notify-send` on Linux) |

A PreToolUse hook that exits with code 2 **blocks the tool call entirely** — this is how `security-check.sh` prevents dangerous commands from ever executing.

---

### Settings & Permissions

**What it is.** `settings.json` controls what Claude is allowed to do in your project. It defines explicit allow/deny lists for tool usage, configures hooks, and sets project-level preferences. This is your security boundary.

**Why it matters.** By default, Claude asks permission for every action. Well-configured permissions let Claude work fluidly on safe operations (reading files, running tests, git commands) while still requiring approval for anything risky. The deny list acts as a hard block — even if Claude tries, denied operations won't execute.

**How it works.** Permissions use pattern matching:

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",      // Any npm script
      "Bash(git status *)",   // Git read operations
      "Read(**)",             // Read any file
      "Write(src/**)",        // Write to src/ only
      "Write(*.md)"           // Write markdown anywhere
    ],
    "deny": [
      "Bash(rm -rf *)",       // Never allow recursive delete
      "Bash(sudo *)",         // Never allow sudo
      "Write(.env*)",         // Never write env files
      "Read(.env*)"           // Never read env files
    ]
  }
}
```

**Scope:** `settings.json` is committed to git (shared with team). `settings.local.json` is gitignored (personal overrides like MCP servers, extra permissions).

---

### MCP Servers — External Tool Integrations

**What they are.** MCP (Model Context Protocol) servers extend Claude's capabilities beyond the local filesystem. They're external processes that give Claude access to documentation, browsers, databases, design tools, and more — all through a standardized protocol.

**Why they matter.** Without MCP servers, Claude can only read/write local files and run shell commands. With them, Claude can look up live library documentation, automate browser interactions, perform structured multi-step reasoning, and integrate with external services. Each server adds specific capabilities that would otherwise require manual copy-paste or context switching.

**Configured in `.mcp.json`:**

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

**Included servers:**

| Server | What it provides |
|---|---|
| **Context7** | Up-to-date documentation and code examples for any library. Claude can look up API docs on demand instead of relying on training data. |
| **Playwright** | Browser automation — navigate pages, click elements, fill forms, take screenshots. Enables E2E testing and web interaction. |
| **Sequential Thinking** | Structured multi-step reasoning for complex problems. Helps Claude break down problems methodically with explicit thought chains. |

**Important:** Each MCP server adds ~2K tokens of overhead. Only enable servers relevant to your current work. You can toggle them in `settings.local.json` via `enabledMcpjsonServers`.

---

## Customizing the Template

### Let Claude Do It

The fastest and most consistent way to customize this template is to **tell Claude what your project is and let it reconfigure everything for you.** Claude understands all these config formats natively — it can rewrite CLAUDE.md, add/remove rules, create new agents, adjust permissions, and update skills in seconds.

Example prompts after cloning:

> "My project is a Go + HTMX web app with SQLite. Reconfigure everything — update CLAUDE.md with my stack, replace rules, and adjust settings.json permissions for Go tooling."

> "Add a Python rule file for my FastAPI backend. It should enforce type hints, async/await patterns, and Pydantic models for validation."

> "Create a test-runner agent that uses sonnet, has access to Bash and Read tools, and follows a TDD workflow."

> "I need a /seed-db skill that reads my schema, generates realistic test data, and inserts it."

### Manual Customization Reference

If you prefer to edit files directly, here's the format for each:

**New rule** — `.claude/rules/<name>.md`:
```yaml
---
paths:
  - "**/*.py"
---

# Python Rules
- Your conventions here...
```

**New agent** — `.claude/agents/<name>.md`:
```yaml
---
name: test-runner
description: Runs tests and reports failures
model: sonnet
tools:
  - Bash
  - Read
  - Grep
---

# Test Runner Agent
Instructions for the agent...
```

**New skill** — `.claude/skills/<name>/SKILL.md`:
```yaml
---
name: seed-db
description: Generate and insert test data
argument-hint: "[table name or 'all']"
---

# Seed Database
Steps to follow for: $ARGUMENTS
```

**Permissions** — `.claude/settings.json`:
```json
{
  "permissions": {
    "allow": ["Bash(go test *)", "Bash(go build *)", "Write(internal/**)"],
    "deny": ["Bash(rm -rf *)"]
  }
}
```

---

## Credits

This template is built on best practices from the [Claude Code Ultimate Guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide/blob/main/guide/ultimate-guide.md) by [Florian Bruniaux](https://github.com/FlorianBruniaux). The guide is the most comprehensive community resource for Claude Code — covering everything from context management to multi-agent workflows, security hooks, and CI/CD integration. Highly recommended reading: [cc.bruniaux.com](https://cc.bruniaux.com/).

## License

MIT — use this template however you like.
