# Agent Agency v0.5.0

**OpenCode-native agents for hybrid web development**

A collection of specialized AI agents that build web applications with explicit workflow enforcement and documentation.

## Quick Start

```bash
# Install agents
git clone https://github.com/dallumnz/agent-agency.git
cd agent-agency
cp -r .opencode/agents/* ~/.opencode/agents/

# Start building
cd ~/projects/your-laravel-app
opencode --agent development-manager
```

## What It Does

The Agent Agency orchestrates AI agents to build features:

1. **Senior-Architect** → Designs system, writes ARCHITECTURE.md
2. **Fullstack-Dev** → Implements the feature
3. **Code-Reviewer** → Quality gate (writes review to file)
4. **Dev-Manager** → Orchestrates workflow, generates handoff

## Workflow

```
Step 0: Delegate to @senior-architect
Step 1: Verify ARCHITECTURE.md was written
Step 2: Delegate to @fullstack-dev → then @code-reviewer
Step 4a: Run version-architecture.sh
Step 4b: Generate handoff
Step 5: Deliver result
```

## Agents

| Agent | Role | Model | Where |
|-------|------|-------|-------|
| Dev-Manager | Orchestrator | gpt-oss-20b (local) | ~/.opencode/agents/ |
| Senior-Architect | System Design | gpt-oss-20b (local) | ~/.opencode/agents/ |
| Fullstack-Dev | Implementation | kimi-k2.5 (API) | ~/.opencode/agents/ |
| Code-Reviewer | Quality | gpt-oss-20b (local) | ~/.opencode/agents/ |

## Key Features

- **Explicit Workflow** — Steps cannot be skipped
- **Architecture Versioning** — ARCHITECTURE.md snapshots to documentation/
- **Code Reviews** — Written to documentation/code-reviews/
- **Handoffs** — Generated via bash scripts
- **Hybrid Models** — Local reasoning + API implementation

## Documentation

- [ARCHITECTURE.md](ARCHITECTURE.md) — Full documentation
- [ROADMAP.md](ROADMAP.md) — Project roadmap
- [documentation/](documentation/) — Versioned snapshots and reviews

## Version

**Current:** v0.5.0

**Changelog:**

- **v0.5.0** — Explicit workflow enforcement, architecture versioning, code review files
- **v0.4.x** — Hybrid architecture, MCP integration
- **v0.3.x** — Early iterations

## License

MIT
