# Agent Agency Architecture

**Version:** 0.3.0
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

## Agent Team (v3.0)

### Orchestrator

| Agent | Role | Model | Primary Function |
|-------|------|-------|-------------------|
| **Dev-Manager** | Team Lead | granite-4-h-tiny | Planning, coordination, agent spawning, report consolidation |

### Utility Agent

| Agent | Role | Model | Primary Function |
|-------|------|-------|-------------------|
| **Context-Manager** | Knowledge Utility | qwen3-14b | Queries RAG system, returns context, tools, skills to calling agent |

### Worker Agents (Scaffold → User Implements)

| Agent | Role | Model | Function |
|-------|------|-------|----------|
| **Fullstack-Dev** | Scaffold Engineer | qwen3-14b | Migrations, models, controllers, routes, views/templates |
| **Code-Reviewer** | Quality Assistant | granite-4-h-tiny | Code review, static analysis |
| **Test-Creator** | Testing Assistant | granite-4-h-tiny | Unit/feature test scaffolding |

---

## Workflow Pattern

### High-Level Flow

```
Dallum + Dev-Manager
    ↓
Dev-Manager (creates plan)
    ↓
Spawns agent(s)
    ↓
Agent calls Context-Manager FIRST (mandatory)
    ↓
Agent works through plan, scaffolds output
    ↓
Agent returns report to Dev-Manager
    ↓
Dev-Manager consolidates
    ↓
User reviews + implements business logic
```

### Detailed Sequence

```
1. REQUEST
   User describes task to Dev-Manager

2. PLAN
   Dev-Manager analyzes request
   Builds execution plan
   Determines which agents to spawn

3. SPAWN
   Dev-Manager spawns worker agent(s)
   Example: "Scaffold a user authentication module"

4. CONTEXT PULL (Mandatory)
   Worker agent calls Context-Manager
   Context-Manager queries RAG system
   Returns relevant: conventions, patterns, tools, skills

5. SCAFFOLD
   Worker agent generates scaffold
   - Migrations, models, controllers
   - Routes, views, components
   - Test files, review comments

6. REPORT
   Worker agent returns report to Dev-Manager
   Dev-Manager consolidates if multiple agents

7. REVIEW + IMPLEMENT
   User reviews scaffold
   Fills in business logic
   Refines to professional standard
```

---

## Context-Manager Agent (v3.0)

### Purpose

Transform static context files into an intelligent utility that:
1. Receives queries from worker agents
2. Queries the RAG corpus
3. Returns relevant context, tools, and skills

### Invocation Pattern

```markdown
@context-manager
Query: "<specific question or context need>"
Project: <project path>
Context Needed: <conventions | patterns | tools | skills | all>
```

### Example Calls

**Fullstack-Dev starting:**
```markdown
@context-manager
Query: "Laravel conventions for authentication modules, current project structure"
Project: ~/projects/my-laravel-app
Context Needed: all
```

**Test-Creator:**
```markdown
@context-manager
Query: "PHPUnit/Laravel testing patterns for feature tests"
Project: ~/projects/my-laravel-app
Context Needed: patterns, tools
```

**Code-Reviewer:**
```markdown
@context-manager
Query: "Laravel code review checklist, security concerns"
Project: ~/projects/my-laravel-app
Context Needed: conventions, skills
```

### RAG System Integration

| Component | Location | Purpose |
|-----------|----------|---------|
| Corpus | ~/projects/agent-research/rag/corpus.db | 125+ indexed chunks |
| Embeddings | text-embedding-nomic-embed-text-v1.5 | Semantic search |
| CLI | python rag.py | Query interface |

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
| **Tests** | Test class structure, assertions | Test data, edge cases |

### Example: Authentication Module

**Agent scaffolds:**
- `database/migrations/*_create_users_table.php`
- `app/Models/User.php` (basic structure)
- `app/Http/Controllers/AuthController.php` (stub methods)
- `routes/auth.php` (basic routes)
- `resources/views/auth/login.blade.php` (form template)
- `tests/Feature/AuthTest.php` (basic test structure)

**User implements:**
- Validation rules in controllers
- Custom accessor/mutator logic
- Complex relationships
- Middleware customization
- Actual test assertions and data

---

## Dev-Manager Responsibilities

### Planning

1. Analyze user request
2. Determine scope (backend, frontend, both)
3. Identify which worker agents needed
4. Build execution sequence
5. Set checkpoints for user review

### Team Building

- Spawns appropriate agents based on task
- Manages dependencies between tasks
- Coordinates parallel vs sequential execution

### Coordination

- Receives reports from worker agents
- Consolidates outputs if multiple agents
- Tracks task completion
- Provides clear summary to user

---

## Worker Agent Responsibilities

### Fullstack-Dev Agent

**Entry point:**
```markdown
@context-manager [get context]
Plan: <task description>
Project: <path>
Constraints: <time limit, quality gates>
```

**Outputs:**
- Database migrations
- Models (with relationships, accessors)
- Controllers (with CRUD stubs)
- Routes
- View templates/components

### Code-Reviewer Agent

**Entry point:**
```markdown
@context-manager [get review checklist]
Files: <list of files to review>
Focus: <security | performance | style | all>
```

**Outputs:**
- Code review report
- Issues found (severity, location, suggestion)
- Security concerns
- Performance considerations

### Test-Creator Agent

**Entry point:**
```markdown
@context-manager [get testing patterns]
Codebase: <path to scaffolded code>
Test Type: <unit | feature | all>
```

**Outputs:**
- Test class structure
- Basic assertions
- Factory/stub templates
- Test data suggestions

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
| Testing | Minimal | Consistent test coverage |
| Review process | Agent-only | Human-in-the-loop |
| Learning | Agent-dependent | Agent-assisted |

### Target Outcomes

> "I built this app more consistently with better testing and review process with a team."

- Consistent scaffolding across projects
- Every feature has tests (agent-assisted)
- Code review happens (agent-assisted)
- User understands and owns the implementation

---

## Open Questions (To Resolve)

### 1. Context-Manager Response Format
How should Context-Manager return data?
- Tool-like invocation?
- Structured JSON?
- Markdown report?

### 2. Debug Agent Fate
Does Debug Agent become Code-Reviewer + Test-Creator, or stay as one agent with split responsibilities?

### 3. Review Consolidation
Does Dev-Manager consolidate all reviews, or does each agent have its own review output?

### 4. File Structure
Keep agents in `~/projects/agent-agency/.opencode/agents/` or restructure?

### 5. RAG Query Interface
How does Context-Manager agent query RAG? Direct CLI or MCP tool?

### 6. Checkpoint Triggers
When does user review happen?
- After each agent?
- After all agents?
- At specific milestones?

---

## Project Structure (Draft)

```
agent-agency/
├── .opencode/
│   └── agents/
│       ├── development-manager.md    # Orchestrator
│       ├── context-manager.md        # RAG utility agent
│       ├── fullstack-dev.md          # Scaffold engineer
│       ├── code-reviewer.md          # Quality assistant
│       └── test-creator.md           # Testing assistant
├── contexts/
│   └── (legacy - migrating to RAG corpus) # Legacy context files, content being indexed to RAG
├── docs/
│   ├── laravel-boost-integration.md  # Pending rewrite for v0.3.0
│   └── workflow.md                    # Pending rewrite for v0.3.0
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
3. Results returned to agent
4. Agent incorporates into scaffolding

---

## Dependencies

### MCP Servers
- **Laravel Boost** — Schema, routes, migrations
- **Filesystem** — Project access

### Local Tools
- **LMStudio** — qwen3-14b (primary), glm-4.6-flash (vision)
- **RAG CLI** — python rag.py

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 0.3.0 | 2026-02-04 | Pivot to assistive, RAG-powered Context-Manager, scaffold scope |
| 0.2.0 | 2026-02-02 | Task graphs, Debug-Agent, file-based context |
| 0.1.0 | 2026-02-01 | Modular refactor — Dev-Manager team model |
| 0.0.1 | 2026-01-31 | Initial setup — Orchestrator, Design, Frontend |

---

## Next Steps

1. [ ] Resolve open questions (Context-Manager format, Debug fate, etc.)
2. [ ] Build Context-Manager agent with RAG integration
3. [ ] Refactor Fullstack-Dev for scaffold scope
4. [ ] Create Code-Reviewer agent
5. [ ] Create Test-Creator agent
6. [ ] Update Dev-Manager for simplified coordination
7. [ ] Test workflow with sample Laravel feature

---

## Documentation Plan

### Pending Rewrite for v0.3.0

| Document | Status | Description |
|----------|--------|-------------|
| `docs/laravel-boost-integration.md` | Pending | Laravel Boost MCP setup (unchanged) |
| `docs/workflow.md` | Pending | v0.3.0 workflow patterns |

### New Documentation Needed

| Document | Purpose |
|----------|---------|
| `docs/context-manager.md` | How Context-Manager queries RAG |
| `docs/scaffolding-patterns.md` | Scaffold scope and patterns |
| `docs/testing-workflow.md` | Test-Creator usage |
| `docs/code-review-workflow.md` | Code-Reviewer usage |

---

*This is a living spec. Update as decisions are made and architecture evolves.*
