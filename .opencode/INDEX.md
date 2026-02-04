# Agent Agency - OpenCode Agent Index

**Version:** 2.0.0
**Last Updated:** 2026-02-01

A modular team of specialized AI agents for web development. Modeled after a development team structure with a team lead and specialist agents.

## Agents

### Primary Agent

| ID | Name | Description |
|----|------|-------------|
| `development-manager` | Development Manager | Senior development team lead that plans, coordinates, and manages multi-agent workflows. Creates execution plans and spawns appropriate specialists. |

### Specialist Subagents

| ID | Description |
|----|-------------|
| `context-manager` | Maintains project architecture, patterns, conventions, and provides contextual insights to development agents. |
| `backend-developer` | Senior backend engineer specializing in PHP 8+ and Laravel. Builds APIs, databases, services, and server-side solutions. |
| `frontend-developer` | Senior frontend engineer specializing in Tailwind CSS, Livewire, and Blade components. Builds accessible, performant user interfaces. |

## Usage

### Starting a Project

Begin with the Development-Manager for complex tasks:
```
Development-Manager will:
1. Analyze your requirements
2. Query context-manager for project architecture
3. Create an execution plan
4. Spawn appropriate specialists (backend, frontend)
5. Coordinate handoffs and validate delivery
```

### Direct Agent Access

**Context-Manager:**
```
Query for project context: architecture, patterns, conventions, design tokens
```

**Backend-Developer:**
```
Use for: API development, database migrations, Laravel services, authentication
```

**Frontend-Developer:**
```
Use for: Blade components, Tailwind styling, Livewire components, responsive layouts
```

## Workflow Patterns

### Sequential
When work has dependencies:
```
Development-Manager → Backend-Developer → Frontend-Developer
```

### Parallel
When work is independent:
```
Development-Manager → Backend-Developer (API)
                    → Frontend-Developer (UI)
```

### Hybrid (Most Common)
```
Development-Manager → Shared foundations
                    → [Parallel: Backend + Frontend]
                    → Integration/validation
```

## Installation

```bash
# Project-specific (recommended)
cp -r .opencode/agent/ /path/to/project/.opencode/agents/
```

## Dependencies

These context files enhance agent performance:

- `contexts/design-tokens.md` - Bootstrap to Tailwind design tokens
- `contexts/frontend-conventions.md` - Tailwind & Blade best practices
- `docs/laravel-boost-integration.md` - Laravel Boost MCP usage

## Technology Stack

- **Editor:** OpenCode (local)
- **Models:** LMStudio local models
  - Development-Manager: granite-4-h-tiny (IBM, fast coordination)
  - Specialists: qwen3-14b (14B, code generation)
- **Backend:** Laravel 12+ with SQLite
- **Styling:** Tailwind CSS v4 with Bootstrap design tokens
- **MCP:** Laravel Boost for schema/routes access

## Version History

### v2.0.0 (Current)
- Modular refactor from project-specific to reusable agents
- Development-Manager replaces Orchestrator (team lead role)
- Added Context-Manager for project knowledge
- Parallel agent coordination support
- All agents now in `.opencode/agent/`

### v1.0.0 (Deprecated)
- Orchestrator, Design Agent, Frontend Agent
- Project-specific implementation
- Sequential handoff pattern

## Changelog

### v2.0.0
- Complete architectural refactor
- New: development-manager, context-manager, backend-developer, frontend-developer
- Removed: orchestrator, design-agent, frontend-agent
- Added: parallel workflow support, context-aware agents
