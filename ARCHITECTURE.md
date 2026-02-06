# Agent Agency Architecture

**Version:** 0.4.0
**Status:** Planning Phase
**Stack:** OpenCode + Laravel Boost MCP + Local LLMs (LMStudio) + Project RAG

---

## The Pivot: Embracing Ecosystem Tools

### What Changed (v0.4.0)

| Before (v0.3.x) | After (v0.4.0) |
|------------------|-----------------|
| Context-Manager as separate RAG agent | **Laravel Boost** provides Laravel context |
| Custom Laravel conventions + patterns | Boost guidelines cover framework patterns |
| Separate Project RAG for domain knowledge | **Project RAG** for app-specific knowledge |
| Build context layer from scratch | Compose Boost + Project RAG |

### Core Insight

> **"Don't own what others maintain better."**

- Laravel Boost handles framework literacy (kept updated by Laravel team)
- Agent Agency focuses on orchestration + project-specific context
- Compose, don't replicate

---

## Architecture Reframe

```
User Request
    ↓
Dev-Manager (orchestrates)
    ├── Worker Agents (task execution)
    ├── Laravel Boost MCP (framework context)
    └── Project RAG (your app context)
    ↓
Result
```

**Layers of Context:**

| Context Type | Provider | Purpose |
|--------------|----------|---------|
| Framework | Laravel Boost MCP | Laravel conventions, routes, schema, docs |
| Ecosystem | Boost Guidelines | Livewire, Tailwind, Pest, Filament patterns |
| Project | Project RAG | Your app's domain, patterns, business logic |
| Task | Meta-Prompts | Agent-specific instructions |

---

## Model Stack

| Agent | Model | Reasoning | Use Case |
|-------|-------|-----------|----------|
| **Dev-Manager** | qwen3-30b | Complex | Planning, coordination, meta-prompts |
| **Fullstack-Dev** | qwen3-30b | Complex | Scaffold generation, testing |
| **Code-Reviewer** | gpt-oss-20b | Fast | Static analysis, reviews |

**Rationale:**
- **30B models** — Complex scaffolding, planning, multi-step reasoning
- **20B model** — Faster, cheaper for lightweight tasks (reviews)

---

## Agent Team (v0.4.0)

### Orchestrator

| Agent | Role | Model | Primary Function |
|-------|------|-------|-----------------|
| **Dev-Manager** | Team Lead | qwen3-30b | Planning, coordination, meta-prompts, sequential task execution |

### Worker Agents (Scaffold → User Implements)

| Agent | Role | Model | Function |
|-------|------|-------|----------|
| **Fullstack-Dev** | Scaffold Engineer | qwen3-30b | Migrations, models, controllers, routes, views, tests |
| **Code-Reviewer** | Quality Assistant | gpt-oss-20b | Code review, static analysis, security |

### Removed

| Agent | Status | Reason |
|-------|--------|--------|
| **Context-Manager** | Removed | Replaced by Laravel Boost MCP + Project RAG |

---

## Context Integration

### Laravel Boost MCP

Fullstack-Dev uses Boost MCP tools for:

| Tool | Purpose |
|------|---------|
| Schema inspection | Read database structure |
| Route listing | Get current routes + middleware |
| Migration generation | Create new migrations |
| Documentation search | Query Laravel docs (17,000+ chunks) |
| Pest integration | Generate test stubs |

### Project RAG

For your application's knowledge:

```
rag.py search "<query>"
  ├── ~/projects/your-app/docs/
  ├── ~/projects/your-app/README.md
  └── Custom patterns + conventions
```

**Invocation:**

```markdown
@context-manager
Query: "<app-specific context need>"
Project: ~/projects/my-laravel-app
Format: markdown
```

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
    Agent uses Boost MCP + Project RAG
    ↓
    Agent scaffolds + reports feedback
    ↓
    Dev-Manager incorporates feedback → adjusts next steps
    ↓
Consolidated report to user
```

### Meta-Prompt Structure

```
# Role
You are [agent name], a [role description].

# Context (from Boost + Project RAG)
[Framework context from Boost MCP]
[Project context from RAG]

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
# Install Laravel Boost
composer require laravel/boost --dev
php artisan boost:install
```

Fullstack-Dev uses Boost MCP to:
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
@code-reviewer
Files to review: [list]
Focus: [security | performance | style | all]
```

---

## Workflow Pattern

### High-Level Flow

```
User Request
    ↓
Dev-Manager (sequential plan + meta-prompts)
    ↓
For each task:
    Spawn agent with meta-prompt
    ↓
    Agent queries Boost MCP (framework)
    ↓
    Agent queries Project RAG (domain)
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
   Example: "Scaffold blog post module"

4. CONTEXT PULL (via Boost + Project RAG)
   Agent uses Boost MCP for:
   - Current schema
   - Route definitions
   - Laravel documentation
   
   Agent queries Project RAG for:
   - App-specific conventions
   - Domain patterns
   - Existing implementations

5. SCAFFOLD
   Fullstack-Dev generates:
   - Migrations, models, controllers
   - Routes, views, components
   - Feature/unit tests (via Boost Pest)

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

## Scaffolding Scope

### What Agents Scaffold

| Component | Description | User Implements |
|-----------|-------------|-----------------|
| **Migrations** | Database tables, columns, indexes | Business logic, relationships |
| **Models** | Class structure, relationships | Custom attributes, complex logic |
| **Controllers** | CRUD methods, request validation | Business rules, complex operations |
| **Routes** | Route definitions, group structure | Route middleware custom logic |
| **Views/Components** | Blade files, Livewire | UI customization, content |
| **Tests** | Feature + Unit test stubs (Pest) | Test data, edge cases, assertions |

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

## Project RAG: Your App's Knowledge

### Purpose

Boost provides Laravel literacy. Project RAG provides **your application's** literacy:

```
What Project RAG Contains:
├── ~/projects/your-app/docs/
│   ├── architecture.md
│   ├── patterns.md
│   └── conventions.md
├── README.md
├── existing implementations
└── domain-specific patterns
```

### Invocation

```bash
# CLI usage
python ~/projects/agent-agency/rag/rag.py search "authentication patterns"

# In agent prompt
Context from Project RAG: [results from query]
```

### Integration Strategy

1. Index project docs during setup
2. Agent queries RAG on context pull
3. Results merged with Boost context
4. Both inform scaffolding decisions

---

## Laravel RAG Exploration (Future)

### Concept

Build a Laravel RAG package that provides:

- Project documentation search
- Custom embedding pipeline
- Artisan commands for indexing
- MCP-compatible interface

### Scope (v0.5.0+)

```
laravel-rag/
├── src/
│   ├── Commands/
│   │   ├── IndexCommand.php
│   │   └── SearchCommand.php
│   ├── Embedding/
│   │   └── EmbeddingService.php
│   └── RagServiceProvider.php
├── config/
│   └── laravel-rag.php
└── composer.json
```

This complements Boost — Boost handles Laravel docs, Laravel RAG handles your app docs.

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Completion rate | "I built this with agent assistance" |
| Code quality | Professional standard |
| Testing | Consistent test coverage (Pest) |
| Review process | Human-in-the-loop |
| Learning | Agent-assisted, not agent-dependent |

### Target Outcomes

> "I built this app more consistently with better testing and review process with a team."

- Consistent scaffolding across projects
- Every feature has tests (agent-assisted)
- Code review happens (agent-assisted)
- User understands and owns the implementation

---

## Project Structure

```
agent-agency/
├── .opencode/
│   └── agents/
│       ├── development-manager.md    # Orchestrator with meta-prompts
│       ├── fullstack-dev.md          # Scaffold engineer + testing
│       └── code-reviewer.md           # Quality assistant
├── rag/
│   ├── rag.py                        # CLI interface (project RAG)
│   └── README.md                      # RAG documentation
├── laravel-rag/                       # Future: Laravel RAG package
├── docs/
│   └── workflow.md
├── ideas/
│   ├── current/
│   └── future/
└── ARCHITECTURE.md                    # This file
```

---

## Dependencies

### MCP Servers
- **Laravel Boost** — Schema, routes, migrations, Pest testing, documentation
- **Filesystem** — Project access

### Local Tools
- **LMStudio** — qwen3-30b, gpt-oss-20b
- **RAG CLI** — python rag.py

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 0.4.0 | 2026-02-07 | Dropped Context-Manager, embraced Laravel Boost, added Project RAG |
| 0.3.1 | 2026-02-05 | Model stack: qwen3-30b + gpt-oss-20b, meta-prompts, combined Fullstack-Dev |
| 0.3.0 | 2026-02-04 | Pivot to assistive, RAG-powered Context-Manager |
| 0.2.0 | 2026-02-02 | Task graphs, Debug-Agent, file-based context |
| 0.1.0 | 2026-02-01 | Modular refactor — Dev-Manager team model |

---

## Next Steps

1. [ ] Update agent definitions (remove Context-Manager)
2. [ ] Define Project RAG indexing strategy
3. [ ] Prototype Dev-Manager with meta-prompts
4. [ ] Test Fullstack-Dev with Boost MCP integration
5. [ ] Explore Laravel RAG package idea

---

## Documentation Plan

| Document | Status | Description |
|----------|--------|-------------|
| `docs/workflow.md` | Rewrite | v0.4.0 workflow with Boost + Project RAG |
| `docs/project-rag.md` | New | Project RAG indexing + usage |
| `docs/laravel-rag.md` | Future | Laravel RAG package specification |

---

*This is a living spec. Update as decisions are made and architecture evolves.*
