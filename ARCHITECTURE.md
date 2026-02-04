# Agent Agency Architecture

**Version:** 0.3.1
**Status:** Working Toward 1.0-Alpha
**Stack:** OpenCode + Laravel Boost MCP + Local LLMs (LMStudio) + RAG System

---

## The Pivot: From Autonomous to Assistive

### What Changed

| Before (v2.x) | After (v3.0) |
|----------------|---------------|
| Agents build complete apps | Agents scaffold, user implements |
| Autonomous execution | Human-in-the-loop at key points |
| Multiple specialist agents | Simplified agent roles |
| Context as static files | Context as RAG-powered utility agent |
| "Agent built this" | "I built this with agent assistance" |

### Core Philosophy

> **"Agents are tools, not magical beings."**

- Agents assist, they don't replace professional judgment
- Quality over velocity — professional standards matter
- Right tool for the job — sometimes that's you writing code
- Scaffolding + implementation beats fully-generated slop

---

## Model Stack

| Agent | Model | Reasoning | Use Case |
|-------|-------|-----------|----------|
| **Dev-Manager** | qwen3-30b | Complex | Planning, coordination, meta-prompts |
| **Fullstack-Dev** | qwen3-30b | Complex | Scaffold generation, testing |
| **Context-Manager** | gpt-oss-20b | Fast | Lightweight context queries |
| **Code-Reviewer** | gpt-oss-20b | Fast | Static analysis, reviews |

**Rationale:**
- **30B models** — Complex scaffolding, planning, multi-step reasoning
- **20B model** — Faster, cheaper for lightweight tasks (context lookups, reviews)

---

## Agent Team (v3.0)

### Orchestrator

| Agent | Role | Model | Primary Function |
|-------|------|-------|-------------------|
| **Dev-Manager** | Team Lead | qwen3-30b | Planning, coordination, meta-prompts, sequential task execution |

### Utility Agent

| Agent | Role | Model | Primary Function |
|-------|------|-------|-------------------|
| **Context-Manager** | Knowledge Utility | gpt-oss-20b | Queries context files, returns to calling agent |

### Worker Agents (Scaffold → User Implements)

| Agent | Role | Model | Function |
|-------|------|-------|----------|
| **Fullstack-Dev** | Scaffold Engineer | qwen3-30b | Migrations, models, controllers, routes, views, tests |
| **Code-Reviewer** | Quality Assistant | gpt-oss-20b | Code review, static analysis, security |

---

## Dev-Manager: Meta-Prompts + Sequential Planning

### Planning Workflow

```
User Request
    ↓
Dev-Manager (analyzes, builds sequential plan)
    ↓
For each task:
    Dev-Manager creates META-PROMPT
    ↓
    Spawn agent with meta-prompt
    ↓
    Agent executes + reports feedback
    ↓
    Dev-Manager incorporates feedback → adjusts next steps
    ↓
Consolidated report to user
```

### Meta-Prompt Structure

```
# Role
You are [agent name], a [role description].

# Context
[Context from Context-Manager]

# Task
[Specific task description]

# Constraints
- [Constraint 1]
- [Constraint 2]

# Success Criteria
- [Criterion 1]
- [Criterion 2]

# Previous Feedback
[Any feedback from prior steps to incorporate]
```

### Sequential Task Execution

1. **Analyze** → Understand request, detect pattern (MVC/API)
2. **Plan** → Build step-by-step task list
3. **Meta-Prompt** → Create agent prompt for each step
4. **Execute** → Spawn agent, collect feedback
5. **Iterate** → Adjust next steps based on feedback
6. **Report** → Consolidate to user

---

## Context-Manager Response Formats

### Format Selection

| Format | Use Case | Example |
|--------|----------|---------|
| **Markdown** | Agent context, conventions, patterns | Rich formatting, flexible, LLM-friendly |
| **JSON** | Tool outputs, structured data, MCP integration | Precise, machine-parseable |

### Response Pattern

**For Agent Context (Markdown):**
```markdown
# Laravel Conventions

## Naming
- Models: Singular, PascalCase (User, BlogPost)
- Controllers: Plural + Controller (UsersController)
- Tables: Plural, snake_case (blog_posts)

## Code Style
- PSR-12 standards
- Laravel facades for common operations
```

**For Tool Data (JSON):**
```json
{
  "schema": {
    "users": {
      "id": "increments",
      "name": "string",
      "email": "string"
    }
  }
}
```

### Invocation Pattern

```markdown
@context-manager
Query: "<specific question or context need>"
Project: <project path>
Format: <markdown | json>
```

---

## Workflow Pattern

### High-Level Flow

```
Dallum + Dev-Manager
    ↓
Dev-Manager (sequential plan + meta-prompts)
    ↓
For each task:
    Spawn agent with meta-prompt
    ↓
    Agent calls Context-Manager FIRST (mandatory)
    ↓
    Agent scaffolds + reports feedback
    ↓
    Dev-Manager adjusts next steps
    ↓
Consolidated report to user
    ↓
User reviews + implements business logic
```

### Detailed Sequence

```
1. REQUEST
   User describes task to Dev-Manager

2. PLAN
   Dev-Manager analyzes request
   Builds sequential task list
   Creates meta-prompts for each agent

3. SPAWN
   Dev-Manager spawns agent with meta-prompt
   Example: "Scaffold user authentication module"

4. CONTEXT PULL (Mandatory)
   Worker agent calls Context-Manager
   Context-Manager returns context (Markdown)
   Worker agent proceeds with task

5. SCAFFOLD
   Fullstack-Dev generates:
   - Migrations, models, controllers
   - Routes, views, components
   - Feature/unit tests (via Laravel Boost Pest)

6. FEEDBACK LOOP
   Agent returns scaffold report to Dev-Manager
   Dev-Manager incorporates feedback
   Adjusts next tasks if needed

7. CONSOLIDATE
   Dev-Manager collects all outputs
   Provides clear summary to user

8. REVIEW + IMPLEMENT
   User reviews scaffold
   Fills in business logic
   Refines to professional standard
```

---

## Fullstack-Dev: Combined Backend + Frontend + Testing

### Why Combined?

Laravel is inherently fullstack:
- Migrations → Models → Controllers → Views/API
- Blade templates + Livewire components
- Pest/Feature tests integrated

Single agent benefits:
- Full picture of feature
- No coordination overhead
- Consistent scaffolding

### What Fullstack-Dev Scaffolds

| Component | Description | User Implements |
|-----------|-------------|-----------------|
| **Migrations** | Tables, columns, indexes | Business logic, relationships |
| **Models** | Class structure, relationships | Custom attributes, complex logic |
| **Controllers** | CRUD stubs, request validation | Business rules, complex operations |
| **Routes** | Route definitions, groups | Middleware customization |
| **Views/Components** | Blade files, Livewire | UI customization, content |
| **Tests** | Feature + Unit tests (Pest) | Test data, edge case assertions |

### Laravel Boost Pest Integration

```bash
# Install Laravel Boost (has Pest skill)
npx clawhub@latest install laravel-boost

# Set OpenCode permissions for MCP access
```

Fullstack-Dev uses Laravel Boost MCP to:
- Read database schema
- Generate migrations
- Create Pest test stubs

---

## Code-Reviewer Agent

### Responsibilities

- Static analysis of scaffolded code
- Security concern identification
- Style compliance checks
- Performance suggestions

### Entry Point

```markdown
@context-manager
Query: "Laravel code review checklist, security concerns"
Project: ~/projects/my-laravel-app
Format: markdown
---
Files to review: [list]
Focus: [security | performance | style | all]
```

---

## Context-Manager Agent (v3.0)

### Purpose

Transform static context files into an intelligent utility that:
1. Receives queries from worker agents
2. Returns relevant context in appropriate format
3. Supports both agent consumption (Markdown) and tools (JSON)

### Invocation Pattern

```markdown
@context-manager
Query: "<specific question or context need>"
Project: <project path>
Format: <markdown | json>
```

### Example Calls

**Fullstack-Dev starting:**
```markdown
@context-manager
Query: "Laravel conventions for authentication modules, current project structure"
Project: ~/projects/my-laravel-app
Format: markdown
```

**Code-Reviewer:**
```markdown
@context-manager
Query: "Laravel code review checklist, security concerns"
Project: ~/projects/my-laravel-app
Format: markdown
```

**Laravel Boost query:**
```markdown
@context-manager
Query: "Get current database schema for users table"
Project: ~/projects/my-laravel-app
Format: json
```

---

## Scaffolding Scope

### What Agents Scaffold

| Component | Description | User Implements |
|-----------|-------------|-----------------|
| **Migrations** | Database tables, columns, indexes | Business logic, relationships |
| **Models** | Class structure, relationships, accessors | Custom attributes, complex logic |
| **Controllers** | CRUD methods, request validation | Business rules, complex operations |
| **Routes** | Route definitions, group structure | Route middleware custom logic |
| **Views/Components** | Blade files, Livewire components | UI customization, content |
| **Tests** | Feature + Unit test stubs (Pest) | Test data, edge cases, assertions |

### Example: Authentication Module

**Agent scaffolds:**
- `database/migrations/*_create_users_table.php`
- `app/Models/User.php` (basic structure)
- `app/Http/Controllers/AuthController.php` (stub methods)
- `routes/auth.php` (basic routes)
- `resources/views/auth/login.blade.php` (form template)
- `tests/Feature/AuthTest.php` (Pest stubs)

**User implements:**
- Validation rules in controllers
- Custom accessor/mutator logic
- Complex relationships
- Middleware customization
- Actual test assertions and data

---

## Review Flow

### Multi-Level Review

```
1. DEV-MANAGER REVIEW
   └─ Consolidates agent reports
   └─ Checks for completeness
   └─ Flags gaps

2. CODE-REVIEWER REVIEW (if spawned)
   └─ Static analysis
   └─ Security scan
   └─ Style compliance

3. USER REVIEW
   └─ Scaffold quality
   └─ Architecture fit
   └─ Business logic requirements
```

---

## Success Metrics

| Metric | Before (v2.x) | After (v3.0) |
|--------|----------------|---------------|
| Completion rate | "Agent built X" | "I built X with agent help" |
| Code quality | Variable | Professional standard |
| Testing | Minimal | Consistent test coverage (Pest) |
| Review process | Agent-only | Human-in-the-loop |
| Learning | Agent-dependent | Agent-assisted |

### Target Outcomes

> "I built this app more consistently with better testing and review process with a team."

- Consistent scaffolding across projects
- Every feature has tests (agent-assisted)
- Code review happens (agent-assisted)
- User understands and owns the implementation

---

## Open Questions (Resolved)

| Question | Decision |
|----------|----------|
| Model selection | qwen3-30b for complex, gpt-oss-20b for lightweight |
| Dev-Manager planning | Sequential tasks + meta-prompts |
| Fullstack agent | Combined (not backend + frontend separate) |
| Context response | Markdown for agents, JSON for tools |
| Testing | Fullstack-Dev creates tests via Laravel Boost Pest |
| Review consolidation | Dev-Manager consolidates all outputs |

---

## Project Structure

```
agent-agency/
├── .opencode/
│   └── agents/
│       ├── development-manager.md    # Orchestrator with meta-prompts
│       ├── context-manager.md        # RAG utility agent
│       ├── fullstack-dev.md          # Scaffold engineer + testing
│       └── code-reviewer.md          # Quality assistant
├── contexts/
│   └── (indexed to RAG corpus)
├── docs/
│   ├── laravel-boost-integration.md
│   └── workflow.md
├── ideas/
│   ├── current/
│   └── future/
├── rag/
│   ├── corpus.db                    # RAG database
│   ├── rag.py                       # CLI interface
│   └── README.md                    # RAG documentation
└── ARCHITECTURE.md                  # This file
```

---

## RAG System Reference

### Current State

| Component | Value |
|-----------|-------|
| Database | ~/projects/agent-research/rag/corpus.db |
| Indexed Chunks | 125+ |
| Embedding Model | text-embedding-nomic-embed-text-v1.5 |
| CLI Commands | list, stats, search "<query>" |

### Integration Plan

1. Context-Manager agent receives query
2. Agent executes `python rag.py search "<query>"`
3. Results returned in requested format (Markdown/JSON)
4. Agent incorporates into scaffolding

---

## Dependencies

### MCP Servers
- **Laravel Boost** — Schema, routes, migrations, Pest testing
- **Filesystem** — Project access

### Local Tools
- **LMStudio** — qwen3-30b, gpt-oss-20b
- **RAG CLI** — python rag.py

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 0.3.1 | 2026-02-05 | Model stack: qwen3-30b + gpt-oss-20b, meta-prompts, combined Fullstack-Dev |
| 0.3.0 | 2026-02-04 | Pivot to assistive, RAG-powered Context-Manager |
| 0.2.0 | 2026-02-02 | Task graphs, Debug-Agent, file-based context |
| 0.1.0 | 2026-02-01 | Modular refactor — Dev-Manager team model |

---

## Next Steps

1. [ ] Build Dev-Manager with meta-prompts + sequential planning
2. [ ] Build Context-Manager with Markdown/JSON response formats
3. [ ] Build Fullstack-Dev with Pest testing via Laravel Boost
4. [ ] Build Code-Reviewer for static analysis
5. [ ] Test workflow with sample Laravel feature

---

## Documentation Plan

### Pending Updates

| Document | Status | Description |
|----------|--------|-------------|
| `docs/laravel-boost-integration.md` | Update | Add Pest testing integration |
| `docs/workflow.md` | Rewrite | v0.3.1 workflow with meta-prompts |

### New Documentation

| Document | Purpose |
|----------|---------|
| `docs/context-manager.md` | Markdown/JSON response patterns |
| `docs/scaffolding-patterns.md` | Fullstack-Dev scaffold scope |
| `docs/meta-prompt-guide.md` | Dev-Manager meta-prompt structure |

---

*This is a living spec. Update as decisions are made and architecture evolves.*
