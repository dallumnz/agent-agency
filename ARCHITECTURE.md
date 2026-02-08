# Agent Agency Architecture

**Version:** 0.4.2
**Status:** In Progress
**Stack:** OpenCode + Laravel Boost MCP + Hybrid LLMs (Local + Kimi K2.5)

---

## The Pivot: Embracing Ecosystem Tools

### What Changed (v0.4.0)

| Before (v0.3.x) | After (v0.4.0) |
|------------------|-----------------|
| Context-Manager as separate RAG agent | **Laravel Boost** provides Laravel context |
| Custom Laravel conventions + patterns | **Boost Guidelines** cover framework patterns |
| Separate Project RAG | **Removed** (not needed) |
| Build context layer from scratch | Use Boost MCP + Guidelines |

### Core Insight

> **"Don't own what others maintain better."**

- Laravel Boost handles framework literacy (kept updated by Laravel team)
- Boost Guidelines cover ecosystem patterns (Livewire, Tailwind, Pest, Filament)
- Agent Agency focuses on orchestration
- Compose, don't replicate

---

## Architecture Reframe (v0.4.2 - Hybrid)

```
User Request
    ↓
Dev-Manager (orchestrates, local reasoning)
    ├── Worker Agents (task execution)
    └── Laravel Boost MCP + Guidelines (framework context)
    ↓
Result
```

### Hybrid Model Strategy

| Agent | Role | Model | Provider | Cost | When Used |
|-------|------|-------|----------|------|-----------|
| **Dev-Manager** | Team Lead | gpt-oss-20b | Local (LMStudio) | Free | Planning, coordination, spawning |
| **Fullstack-Dev** | Scaffold Engineer | kimi-k2.5-think | API (OpenCode Zen) | Pay-as-you-go | Heavy scaffolding, complex migrations |
| **Code-Reviewer** | Quality Assistant | gpt-oss-20b | Local (LMStudio) | Free | Static analysis, security, reviews |

### Why This Split?

| Component | Local Reasoning (20B) | Paid API (Kimi K2.5) |
|-----------|----------------------|---------------------|
| Dev-Manager | ✅ Lightweight spawning, planning | ❌ Unnecessary cost |
| Fullstack-Dev | ❌ VRAM unstable on complex tasks | ✅ MoE strength, reliable |
| Code-Reviewer | ✅ Fast, analysis-focused | ❌ Overkill |

### Cost Estimate

| Task | Fullstack-Dev Tokens | Estimated Cost |
|------|---------------------|----------------|
| Simple CRUD | 5K-10K input | $0.01-0.03 |
| Complex feature | 20K-50K input | $0.03-0.15 |
| Full module | 50K-100K input | $0.10-0.30 |

**Reality:** ~$0.10-0.50 per feature scaffold. Pay-as-you-go via OpenCode Zen.

---

## Agent Team (v0.4.2 - Hybrid)

### Orchestrator

| Agent | Role | Model | Provider | Primary Function |
|-------|------|-------|----------|-----------------|
| **Dev-Manager** | Team Lead | gpt-oss-20b | Local (LMStudio) | Planning, coordination, meta-prompts, sequential task execution |

### Worker Agents

| Agent | Role | Model | Provider | Function |
|-------|------|-------|----------|----------|
| **Fullstack-Dev** | Scaffold Engineer | kimi-k2.5-think | API (OpenCode Zen) | Migrations, models, controllers, routes, views, tests |
| **Code-Reviewer** | Quality Assistant | gpt-oss-20b | Local (LMStudio) | Code review, static analysis, security |

### Removed

| Agent | Status | Reason |
|-------|--------|--------|
| **Context-Manager** | Removed | Replaced by Laravel Boost MCP + Guidelines |
| **Project RAG** | Removed | Boost Guidelines cover patterns |

### Why Kimi K2.5 for Fullstack-Dev?

- **MoE (Mixture of Experts)** strength for complex scaffolding
- Long context (200K+ tokens) handles large Laravel projects
- Reliable API = no VRAM instability
- Pay-as-you-go via OpenCode Zen ($0.60 input / $3.00 per 1M)
- Reviews indicate excellent code generation quality

### Why Local for Dev-Manager + Code-Reviewer?

- **Dev-Manager:** Lightweight orchestration, spawning, planning → 20B reasoning model handles fine
- **Code-Reviewer:** Fast analysis, pattern matching → 20B is perfect for static analysis
- **Cost:** Zero for planning + review tasks
- **Privacy:** Project context stays local

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

### Boost Guidelines

| Pattern | Source |
|---------|--------|
| Livewire | Boost Guidelines |
| Tailwind | Boost Guidelines |
| Pest testing | Boost Guidelines |
| Filament | Boost Guidelines |

---

## Dev-Manager: Meta-Prompts + Sequential Planning

### Planning Workflow

```
User Request
    ↓
Dev-Manager (analyzes, builds sequential plan, local reasoning)
    ↓
For each task:
    Dev-Manager creates META-PROMPT
    ↓
    Spawn/Select agent (local or API based on task)
    ↓
    Agent uses Boost MCP
    ↓
    Agent scaffolds + reports feedback
    ↓
    Dev-Manager incorporates feedback → adjusts next steps
    ↓
Consolidated report to user
```

### Agent Selection Logic

| Task Type | Agent | Provider | When |
|-----------|-------|----------|------|
| Planning, coordination | Dev-Manager | Local (20B) | Always starts here |
| Complex scaffolding | Fullstack-Dev | API (Kimi K2.5) | Heavy lifting, migrations |
| Reviews, analysis | Code-Reviewer | Local (20B) | Quality gate |

### Meta-Prompt Structure

```
# Role
You are [agent name], a [role description].

# Context (from Laravel Boost MCP)
[Framework context from Boost MCP]

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

4. CONTEXT PULL (via Boost MCP)
   Agent uses Boost MCP for:
   - Current schema
   - Route definitions
   - Laravel documentation
   - Boost Guidelines for patterns

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

### Local Models (LMStudio)
- **gpt-oss-20b** — Reasoning model for Dev-Manager + Code-Reviewer

### API Models (OpenCode Zen)
- **kimi-k2.5-think** — MoE model for Fullstack-Dev (pay-as-you-go)

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 0.4.2 | 2026-02-08 | Hybrid architecture (local reasoning + Kimi K2.5 API) |
| 0.4.1 | 2026-02-08 | FAILED - DeepSeek R1 crash, workers wouldn't spawn |
| 0.4.0 | 2026-02-07 | Dropped Context-Manager, removed Project RAG, use Boost Guidelines |
| 0.3.1 | 2026-02-05 | Model stack: qwen3-30b + gpt-oss-20b, meta-prompts, combined Fullstack-Dev |
| 0.3.0 | 2026-02-04 | Pivot to assistive, RAG-powered Context-Manager |
| 0.2.0 | 2026-02-02 | Task graphs, Debug-Agent, file-based context |
| 0.1.0 | 2026-02-01 | Modular refactor — Dev-Manager team model |

---

## Next Steps

1. [x] Define hybrid architecture (local + API)
2. [ ] Update agent definitions
   - [ ] Fix Dev-Manager (remove @context-manager, update model)
   - [ ] Update Fullstack-Dev (add Kimi K2.5 reference)
   - [ ] Verify Code-Reviewer
3. [ ] Test Dev-Manager spawning Kimi K2.5 Fullstack-Dev
4. [ ] Prototype with sample Laravel feature

---

## Documentation Plan

| Document | Status | Description |
|----------|--------|-------------|
| `docs/workflow.md` | Rewrite | v0.4.0 workflow with Boost MCP |

---

*This is a living spec. Update as decisions are made and architecture evolves.*
