# Agent Agency Architecture

**Version:** 0.4.5
**Status:** In Progress
**Stack:** OpenCode + Laravel Boost MCP + Hybrid LLMs (Local + API) + handoff MCP

---

## The Pivot: Embracing Ecosystem Tools

### What Changed (v0.4.0)

| Before (v0.3.x) | After (v0.4.0) |
|------------------|-----------------|
| Context-Manager as separate RAG agent | **Laravel Boost** provides Laravel context |
| Custom Laravel conventions + patterns | **Boost Guidelines** cover ecosystem patterns |
| Separate Project RAG | **Removed** (not needed) |
| Build context layer from scratch | Use Boost MCP + Guidelines |

### Core Insight

> **"Don't own what others maintain better."**

- Laravel Boost handles framework literacy (kept updated by Laravel team)
- Boost Guidelines cover ecosystem patterns (Livewire, Tailwind, Pest, Filament)
- Agent Agency focuses on orchestration
- Compose, don't replicate

---

## Architecture Reframe (v0.4.3 - Separation of Concerns)

```
User Request
    ↓
Dev-Manager (pure orchestration)
    ├── Senior-Architect (upfront planning)
    │   Returns: exact files, schemas, requirements
    │
    ├── Fullstack-Dev (execution)
    │
    └── Code-Reviewer (quality gate)
    ↓
Result
```

### Why Separation of Concerns?

| Problem | Solution |
|---------|----------|
| Dev-Manager doing two jobs (planning + orchestration) | Senior-Architect handles upfront planning |
| Scope too big | Senior-Architect breaks into exact files |
| Missing edge cases | Senior-Architect documents boundaries |

### The Flow

```
1. User Request → Dev-Manager
2. Dev-Manager → Senior-Architect (figure out details)
3. Senior-Architect returns: exact files, schemas, requirements
4. Dev-Manager → Fullstack-Dev (execute the plan)
5. Dev-Manager → Code-Reviewer (quality gate)
6. Result → User
```

---

## Agent Team (v0.4.3 - Separation of Concerns)

### Orchestrator

| Agent | Role | Model | Provider | Primary Function |
|-------|------|-------|----------|-----------------|
| **Dev-Manager** | Team Lead | gpt-oss-20b | Local (LMStudio) | Pure orchestration — spawns agents, consolidates results |

### Worker Agents

| Agent | Role | Model | Provider | Function |
|-------|------|-------|----------|----------|
| **Senior-Architect** | Planner | gpt-oss-20b | Local (LMStudio) | Upfront planning, detailed specs, exact files, schemas |
| **Fullstack-Dev** | Scaffold Engineer | kimi-k2.5 | API (OpenCode Zen) | Implementation, scaffolding, CRUD features |
| **Code-Reviewer** | Quality Assistant | gpt-oss-20b | Local (LMStudio) | Code review, static analysis, security |

### Agent Responsibilities

| Agent | Does | Does NOT |
|-------|------|----------|
| **Senior-Architect** | Spends time upfront, figures out details, outputs exact files, schemas, requirements | Execution (leaves that to Fullstack-Dev) |
| **Dev-Manager** | Pure orchestration — spawns agents, consolidates results, enforces handoffs | Upfront planning (that's Senior-Architect's job) |
| **Fullstack-Dev** | Implementation based on Senior-Architect's plan | Planning (Dev-Manager handles that) |
| **Code-Reviewer** | Quality checks, security reviews | Planning or execution |

---

## Hybrid Model Strategy

| Agent | Role | Model | Provider | Cost | When Used |
|-------|------|-------|----------|------|-----------|
| **Dev-Manager** | Team Lead | gpt-oss-20b | Local (LMStudio) | Free | Planning, coordination, spawning |
| **Senior-Architect** | Planner | gpt-oss-20b | Local (LMStudio) | Free | Upfront planning, detailed specs |
| **Fullstack-Dev** | Scaffold Engineer | kimi-k2.5-think | API (OpenCode Zen) | Pay-as-you-go | Heavy scaffolding, complex migrations |
| **Code-Reviewer** | Quality Assistant | gpt-oss-20b | Local (LMStudio) | Free | Static analysis, security, reviews |

### Cost Estimate

| Task | Fullstack-Dev Tokens | Estimated Cost |
|------|---------------------|----------------|
| Simple CRUD | 5K-10K input | $0.01-0.03 |
| Complex feature | 20K-50K input | $0.03-0.15 |
| Full module | 50K-100K input | $0.10-0.30 |

**Reality:** ~$0.10-0.50 per feature scaffold. Pay-as-you-go via OpenCode Zen.

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

## Senior-Architect: Upfront Planning

### Step 0: Requirements Gathering (CRITICAL)

Before generating any architecture, Senior-Architect MUST:

1. **Read ARCHITECTURE.md** — Understand current state
2. **Check migrations/models/routes** — Use Glob/Read to understand schema
3. **Gather requirements from Dev-Manager** — What's being built? Why? How?
4. **Document edge cases** — What could go wrong? What are the boundaries?
5. **Output a DETAILED implementation plan** — Exact files, schemas, interfaces, tests

### Senior-Architect's Output

```markdown
## Implementation Plan: [Feature Name]

### 1. Requirements Summary
- What needs to be built
- Why it's needed
- How it should work

### 2. Database Schema Changes
```php
// Exact migration code
```

### 3. Models Required
| Model | Location | Purpose |

### 4. Controllers Required
| Controller | Location | Methods |

### 5. Routes Required
```php
// Exact route definitions
```

### 6. Tests Required
| Test | Location | Purpose |

### 7. Files to Create (Exact Paths)
- `app/Models/Feature.php`
- `database/migrations/YYYY_MM_DD_HHMMSS_create_feature_table.php`
- `tests/Unit/Feature/FeatureTest.php`

### 8. Edge Cases to Handle
- What happens when X is null?
- What validation is needed?

### 9. Integration Points
- Does this feature interact with existing models?
```

---

## Dev-Manager: Pure Orchestration

### What Dev-Manager Does

1. **Analyze Request** — Is this new (spawn Senior-Architect) or existing patterns (spawn Fullstack-Dev)?
2. **Gather Quick Context** — Check ARCHITECTURE.md, use Boost MCP for schema/routes
3. **Spawn Appropriate Agent** — Based on request type
4. **Consolidate Results** — Collect outputs, enforce handoffs
5. **Deliver to User** — Clear summary

### What Dev-Manager Does NOT Do

- ❌ Upfront planning (that's Senior-Architect's job)
- ❌ Implementation (that's Fullstack-Dev's job)
- ❌ Code review (that's Code-Reviewer's job)

### Spawning Logic

| Request Type | Action |
|--------------|--------|
| New feature / complex system | Spawn @senior-architect first |
| Existing patterns / simple feature | Spawn @fullstack-dev directly |
| Code review | Spawn @code-reviewer |
| Continue from architecture | Spawn @fullstack-dev with Senior-Architect's plan |

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

### High-Level Flow (Separation of Concerns)

```
User Request
    ↓
Dev-Manager (analyzes, decides who to spawn)
    │
    ├─→ Senior-Architect (new features)
    │       Returns: exact files, schemas, requirements
    │       ↓
    │
    └─→ Fullstack-Dev (execution)
            Uses: Senior-Architect's plan + Boost MCP
            ↓
    → Code-Reviewer (quality gate, optional)
    ↓
Consolidated report to user
```

### Detailed Sequence

```
1. REQUEST
   User describes task to Dev-Manager

2. ANALYZE
   Dev-Manager decides:
   - New feature? → Spawn Senior-Architect
   - Existing patterns? → Spawn Fullstack-Dev directly

3. PLANNING (Senior-Architect for new features)
   - Reads requirements from Dev-Manager
   - Checks existing codebase (ARCHITECTURE.md, migrations)
   - Documents edge cases and boundaries
   - Outputs: exact files, schemas, requirements

4. EXECUTION (Fullstack-Dev)
   - Receives Senior-Architect's plan (or uses existing patterns)
   - Queries Boost MCP for framework context
   - Scaffolds: migrations, models, controllers, routes, views, tests

5. REVIEW (Code-Reviewer, optional)
   - Static analysis of scaffolded code
   - Security scan
   - Performance suggestions

6. CONSOLIDATE
   Dev-Manager collects all outputs
   Enforces handoff protocol
   Provides clear summary to user
```

---

## Handoff Protocol (MANDATORY)

### Why Handoffs Matter

- Prevents drift between sessions
- Documents schema changes, test status, pending work
- Enables true multi-session development
- **Without handoffs → orphaned work → fragmentation**

### When to Create a Handoff

1. **Before task completion** — Always generate handoff before finishing
2. **When switching contexts** — When moving to different work
3. **When agent returns control** — Workers must handoff to Dev-Manager
4. **End of session** — Generate handoff before closing

### Handoff Requirements

| Agent | Responsibility |
|-------|----------------|
| Senior-Architect | Documents planning decisions, edge cases, exact files |
| Fullstack-Dev | Summarizes work completed, files created, issues encountered |
| Code-Reviewer | Lists concerns found, severity, recommendations |
| Dev-Manager | Consolidates all, provides next steps, current state |

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
│       ├── development-manager.md    # Pure orchestrator
│       ├── senior-architect.md       # Upfront planning
│       ├── fullstack-dev.md          # Scaffold engineer
│       └── code-reviewer.md          # Quality assistant
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
- **gpt-oss-20b** — Reasoning model for Dev-Manager, Senior-Architect, Code-Reviewer

### API Models (OpenCode Zen)
- **kimi-k2.5-think** — MoE model for Fullstack-Dev (pay-as-you-go)

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 0.4.5 | 2026-02-12 | Make handoff MCP self-contained (.opencode/scripts/) |
| 0.4.4 | 2026-02-12 | Documentation structure, MCP handoff tool, post-session hook |
| 0.4.3 | 2026-02-12 | Separation of Concerns: Senior-Architect handles upfront planning, Dev-Manager pure orchestration |
| 0.4.2 | 2026-02-08 | Hybrid architecture (local reasoning + Kimi K2.5 API) |
| 0.4.1 | 2026-02-08 | FAILED - DeepSeek R1 crash, workers wouldn't spawn |
| 0.4.0 | 2026-02-07 | Dropped Context-Manager, removed Project RAG, use Boost Guidelines |
| 0.3.1 | 2026-02-05 | Model stack: qwen3-30b + gpt-oss-20b, meta-prompts, combined Fullstack-Dev |
| 0.3.0 | 2026-02-04 | Pivot to assistive, RAG-powered Context-Manager |
| 0.2.0 | 2026-02-02 | Task graphs, Debug-Agent, file-based context |
| 0.1.0 | 2026-02-01 | Modular refactor — Dev-Manager team model |

---

## Key Insights

### "If we are to solve complex problems, then we have to spend more time working out the details."

This principle drove the separation of concerns:
- Dallum + Claw work **with** Senior-Architect to design
- Dev-Manager executes the plan
- Each agent has one job

### Separation of Benefits

| Before | After |
|--------|-------|
| Dev-Manager planning + orchestrating | Senior-Architect plans, Dev-Manager orchestrates |
| Scope too big | Exact files, smaller chunks |
| Missing edge cases | Documented in Senior-Architect's output |

---

## Documentation Structure (v0.4.4)

### Directory Layout

```
project/
├── ARCHITECTURE.md              ← Latest version (always current)
├── documentation/
│   ├── architecture/
│   │   ├── ARCHITECTURE_2026-02-09.md
│   │   ├── ARCHITECTURE_2026-02-12.md
│   │   └── ARCHITECTURE_latest.md → copy of current
│   ├── tasks/
│   │   ├── feature-name.md
│   │   └── bug-fix.md
│   └── handoffs/
│       ├── HANDOFF_2026-02-12.md
│       └── HANDOFF_2026-02-13.md
```

### Rules

1. **ARCHITECTURE.md** — Always the latest version in project root
2. **Snapshots** — After major features, copy ARCHITECTURE.md to `documentation/architecture/ARCHITECTURE_YYYY-MM-DD.md`
3. **Tasks** — Store in `documentation/tasks/` (moved from `TASKS/` or `tasks/`)
4. **Handoffs** — Store in `documentation/handoffs/` (moved from root or `handoffs/`)

### Post-Session Hook

Run after each session to snapshot ARCHITECTURE.md:

```bash
python /home/dallum/.openclaw/workspace/scripts/post-session-hook.py /path/to/project
```

---

## MCP Tools (v0.4.4)

### handoff MCP Tool

Exposes handoff functionality as an MCP tool for seamless integration.

**Configuration:**

```json
// In project's .opencode/mcp.json
{
  "mcp": {
    "handoff": {
      "type": "stdio",
      "enabled": true,
      "command": [
        "python",
        "/home/dallum/.openclaw/workspace/skills/handoff-tool/scripts/mcp_wrapper.py"
      ]
    }
  }
}
```

**Available Tools:**

| Tool | Purpose |
|------|---------|
| `handoff.generate` | Create handoff document |
| `handoff.status` | Check handoff status |
| `handoff.resume` | Resume from handoff |

**Usage in Prompts:**

```yaml
After completing the task, call handoff.generate with:
- path: /home/dallum/projects/project-name
- task: "Feature name"
- completed: ["Item 1", "Item 2"]
- next_steps: ["Next step 1", "Next step 2"]
```

---

*This is a living spec. Update as decisions are made and architecture evolves.*
