# Agent Agency Roadmap

**Version:** 1.0-Alpha
**Last Updated:** 2026-02-07
**Stack:** OpenCode + Laravel Boost MCP + Local LLMs + Project RAG

---

## Vision

Build an AI-powered development assistant that:
- Leverages existing ecosystem tools (Laravel Boost, Claude patterns)
- Focuses on orchestration over replication
- Provides assistive scaffolding with human-in-the-loop
- Runs entirely on local infrastructure

---

## Milestones

### Milestone 1: Foundation ✓ (Completed)
**Status:** Done

- [x] Define architecture (v0.1.0 - v0.3.x iterations)
- [x] Establish model stack (qwen3-30b + gpt-oss-20b)
- [x] Set up LMStudio configuration
- [x] Initial RAG system (sqlite-vec)
- [x] First successful component (session-card.blade.php)

### Milestone 2: Architecture Refinement ✓ (Current)
**Status:** In Progress

- [x] **v0.4.0:** Embrace Laravel Boost (dropped Context-Manager)
- [x] Defined Project RAG layer
- [x] Architecture documentation updated

### Milestone 3: Core Skills Development
**Status:** Planned

| Skill | Purpose | Priority |
|-------|---------|----------|
| **handoff-tool** | Session/agent handoff for continuation | High |
| **commit-tool** | Quality gates before git operations | High |
| **wrapup-tool** | End-of-session ritual | Medium |
| **insights-tool** | Correction tracking + analytics | Medium |
| **memory-tool** | SQLite + FTS5 for learnings | Medium |

### Milestone 4: Agent Implementation
**Status:** Planned

| Agent | Role | Dependencies |
|-------|------|--------------|
| **Dev-Manager** | Orchestrator, planning, meta-prompts | handoff-tool |
| **Fullstack-Dev** | Scaffold engineer | Laravel Boost MCP, commit-tool |
| **Code-Reviewer** | Quality assistant | insights-tool, commit-tool |

### Milestone 5: Integration Testing
**Status:** Planned

- [ ] Build sample Laravel feature end-to-end
- [ ] Test agent handoff flow
- [ ] Verify Boost MCP integration
- [ ] Validate Project RAG queries

### Milestone 6: Documentation & Polish
**Status:** Planned

- [ ] Complete SKILL.md files for all skills
- [ ] Workflow documentation
- [ ] Example patterns
- [ ] Contributing guide

---

## Skill Development Order

### Phase 1: Handoff & Session Tools

1. **handoff-tool** (In Progress)
   - Session handoff documents
   - Agent-to-agent handoff
   - Resume capability
   - Status checking
   
   **Status:** SKILL.md created, scripts written, needs testing

2. **commit-tool** (Next)
   - Quality gates (lint, typecheck, tests)
   - Pre-commit hooks
   - Post-commit verification
   
   **Dependencies:** handoff-tool (for recording commits)

### Phase 2: Workflow Tools

3. **wrapup-tool**
   - End-of-session checklist
   - Learnings extraction
   - Memory updates
   
   **Dependencies:** memory-tool

4. **insights-tool**
   - Correction heatmap
   - Session analytics
   - Learning patterns
   
   **Dependencies:** memory-tool

### Phase 3: Memory & Learning

5. **memory-tool**
   - SQLite + FTS5 storage
   - Categorized learnings
   - Search functionality
   
   **Dependencies:** None (foundational)

---

## Architecture Evolution

```
v0.1.0  Initial modular refactor
v0.2.0  Task graphs, Debug-Agent
v0.3.0  Pivot to assistive, RAG-powered Context-Manager
v0.3.1  Model stack defined (qwen3-30b + gpt-oss-20b)
v0.4.0  Embrace Laravel Boost, drop Context-Manager ⬅️ You are here
v0.5.0  Core skills implemented
v0.6.0  Agents operational
v0.7.0  Integration testing
v1.0.0  Alpha release
```

---

## Key Decisions

| Version | Decision | Rationale |
|---------|----------|-----------|
| v0.4.0 | Drop Context-Manager | Laravel Boost covers framework context |
| v0.4.0 | Add Project RAG | Your app's domain knowledge is unique |
| v0.4.0 | Adopt Claude patterns | Leverage ecosystem, adapt to OpenCode |
| v0.4.0 | Local LLMs only | Privacy, cost, control |

---

## Dependencies

### External

| Tool | Purpose | Status |
|------|---------|--------|
| **Laravel Boost MCP** | Framework context | Available |
| **LMStudio** | Local models | Configured |
| **sqlite-vec** | Vector search | Available |
| **OpenCode** | Agent platform | In use |

### Internal (To Build)

| Component | Status |
|-----------|--------|
| handoff-tool | SKILL.md + script created |
| commit-tool | Not started |
| wrapup-tool | Not started |
| insights-tool | Not started |
| memory-tool | Not started |
| Project RAG indexing | Not started |

---

## Exploration Topics

### Future Consideration 1: Laravel RAG Package

Build a Laravel RAG package that provides:
- Project documentation search
- Custom embedding pipeline
- Artisan commands for indexing
- MCP-compatible interface

**Status:** Concept only, post-v1.0

### Future Consideration 2: Claude Pattern Porting

Port more pro-workflow patterns to OpenCode skills:

| Pattern | Port Status |
|---------|------------|
| /handoff | ✅ handoff-tool |
| /commit | ⏳ commit-tool |
| /wrap-up | ⏳ wrapup-tool |
| /replay | ⏳ memory-tool |
| Scout Agent | ⏳ Dev-Manager |
| Drift Detection | ⏳ Dev-Manager checkpoints |

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Ecosystem pace | Constant change | Focus on orchestration, not replication |
| Model availability | Quality | Test with available models, adjust stack |
| Skill complexity | Adoption | Start simple, iterate based on usage |
| Context bloat | Performance | RAG for relevance, not volume |

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Handoff resume time | <5 minutes |
| Scaffold accuracy | >80% without correction |
| Agent handoff success | 100% (no context loss) |
| Local-only operation | 100% (no external APIs) |

---

## Getting Started

### Prerequisites

```bash
# LMStudio running with models
# OpenCode installed
# Laravel Boost MCP configured
```

### Quick Start (Future)

```bash
# Install Agent Agency
git clone ~/projects/agent-agency
cd agent-agency

# Set up skills
cp -r skills/* ~/.openclaw/skills/

# Configure agents
cp .opencode/agents/* ~/.openclaw/agents/

# Start development
cd ~/projects/your-laravel-app
opencode
```

---

## Contributing

This is a personal/tooling project. Contributions welcome via:
- Issues for bugs or features
- PRs for skills or improvements
- Discussion for architecture decisions

---

*Roadmap is a living document. Update as progress is made.*
