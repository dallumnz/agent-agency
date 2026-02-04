# Agent Agency v2.1

A collection of OpenCode-native agents for web development with local LLMs.

## Overview

An "agency" of specialized AI agents that build web applications following a team-based workflow:

1. **Development-Manager** — Plans work and coordinates agents
2. **Backend-Developer** — Laravel APIs, migrations, controllers
3. **Frontend-Developer** — Tailwind, Livewire, Blade components
4. **Debug-Agent** — Validates work before proceeding

## Architecture

```
User Request
    ↓
Development-Manager
    ├→ Load context files (3 Markdown files)
    ├→ Build task dependency graph
    ├→ Execute graph
    │   ├→ @backend-developer
    │   ├→ @frontend-developer
    │   └→ @debug-agent (validation)
    ↓
Delivered Solution
```

See [ARCHITECTURE.md](ARCHITECTURE.md) for full details.

## Quick Start

### Prerequisites

1. **OpenCode** — https://opencode.ai/download
2. **LMStudio** — https://lmstudio.ai/ with model loaded (qwen3-14b recommended)

### Step 1: Configure LMStudio

1. Open LMStudio → Local Server
2. Select `qwen3-14b` (or equivalent)
3. Click **Start Server** (default: http://localhost:1234)

### Step 2: Install Agents and Contexts

```bash
cp -r .opencode/agents/* ~/.opencode/agents/
cp -r contexts/* ~/projects/agent-agency/contexts/
```

### Step 3: (Optional) Add Laravel Boost

For Laravel projects:

```bash
cd your-laravel-project
composer require laravel/boost --dev
php artisan boost:install
```

### Step 4: Start with Development-Manager

```bash
opencode --model lmstudio/qwen3-14b --agent development-manager
```

## Agent Reference

### Development-Manager

**Role:** Team lead, planner, coordinator

**What it does:**
- Loads context files for project understanding
- Analyzes requests and detects MVC vs API patterns
- Builds task dependency graphs
- Spawns @backend-developer, @frontend-developer, @debug-agent
- Validates delivery against requirements

**Context files loaded:**
- `contexts/project/architecture.md`
- `contexts/laravel/conventions.md`
- `contexts/laravel/patterns.md`

### Backend-Developer

**Role:** Server-side engineer

**What it does:**
- Creates migrations, models, controllers
- Builds RESTful APIs or MVC controllers
- Follows Laravel conventions from context files

**Context files loaded:**
- `contexts/laravel/conventions.md`
- `contexts/laravel/patterns.md`

### Frontend-Developer

**Role:** UI engineer

**What it does:**
- Creates Blade components and Livewire components
- Applies Tailwind CSS with design tokens
- Integrates with backend APIs

**Context files loaded:**
- `contexts/frontend/conventions.md`
- `contexts/project/architecture.md`

### Debug-Agent

**Role:** QA specialist

**What it does:**
- Validates migrations run correctly
- Checks PHP and Blade syntax
- Tests endpoint responses
- Verifies full CRUD workflow

**Validation types:**
- Backend (migrations, models, controllers)
- Frontend (Blade, Tailwind, Livewire)
- Integration (full CRUD workflow)

## Context System

Instead of a Context-Manager agent, context is stored as Markdown files:

```
contexts/
├── index.md                      # Quick reference
├── laravel/
│   ├── conventions.md            # Naming, code style, patterns
│   └── patterns.md               # MVC vs API decision tree
├── frontend/
│   └── conventions.md            # Tailwind tokens, components
└── project/
    └── architecture.md           # Project structure, workflow
```

## Task Dependency Graph

Development-Manager builds explicit graphs:

| Pattern | Use Case | Flow |
|---------|----------|------|
| **Sequential** | MVC CRUD | Backend → Verify → Frontend → Verify |
| **Parallel** | Independent tasks | All parallel → Verify |
| **Hybrid** | API + Admin UI | Backend → [Parallel: Frontend, Features] → Verify |

## Project Structure

```
agent-agency/
├── .opencode/
│   └── agents/
│       ├── development-manager.md    # Team lead with task graphs
│       ├── backend-developer.md      # Laravel specialist
│       ├── frontend-developer.md     # Tailwind/Livewire specialist
│       └── debug-agent.md            # QA validation
├── contexts/
│   ├── index.md
│   ├── laravel/
│   │   ├── conventions.md
│   │   └── patterns.md
│   ├── frontend/
│   │   └── conventions.md
│   └── project/
│       └── architecture.md
├── docs/
│   ├── bootstrap-tailwind-mapping.md
│   ├── laravel-boost-integration.md
│   └── workflow.md
├── ideas/
│   ├── current/
│   └── future/
├── ARCHITECTURE.md                   # Full architecture docs
└── README.md
```

## Stack

| Component | Technology |
|-----------|------------|
| Editor | OpenCode |
| Model | LMStudio (qwen3-14b, 14B parameters) |
| Backend | Laravel 12 with SQLite |
| Styling | Tailwind CSS v4 with Bootstrap tokens |
| Components | Blade + Livewire |
| MCP | Laravel Boost |

## Workflow Example

**Request:** "Create a todo list feature"

1. **Development-Manager** loads context, detects MVC pattern
2. **Task Graph:** Backend → Verify → Frontend → Verify
3. **@backend-developer** creates:
   - Migration for todos table
   - Todo model
   - TodoController
   - Routes
4. **@debug-agent** validates: migration runs, endpoints respond
5. **@frontend-developer** creates:
   - Livewire TodoManager component
   - Blade view
6. **@debug-agent** validates: full CRUD workflow works
7. **Complete** — todo list feature delivered

## Requirements

- OpenCode editor
- LMStudio with local model (qwen3-14b recommended)
- Laravel 12 (for Laravel projects)
- Tailwind CSS v4 (for styling)

## License

MIT

## Version History

- **1.0.0**: Initial — Orchestrator, Design, Frontend agents
- **2.0.0**: Modular refactor — Development-Manager team model
- **2.1.0**: File-based context, task graphs, Debug-Agent
