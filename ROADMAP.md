# Agent Agency Roadmap

**Version:** 0.4.2
**Last Updated:** 2026-02-08
**Stack:** OpenCode + Laravel Boost MCP + Hybrid LLMs (Local Reasoning + Kimi K2.5 API)

---

## Vision

Build an AI-powered development assistant that:
- Leverages existing ecosystem tools (Laravel Boost, Claude patterns)
- Uses hybrid local + API models for optimal performance/cost
- Focuses on orchestration over replication
- Provides assistive scaffolding with human-in-the-loop
- Runs primarily on local infrastructure with API backup for heavy lifting

---

## Milestones

### Milestone 1: Foundation ✓ (Completed)
**Status:** Done

- [x] Define architecture (v0.1.0 - v0.3.x iterations)
- [x] Establish model stack (qwen3-30b + gpt-oss-20b)
- [x] Set up LMStudio configuration
- [x] Initial RAG system (sqlite-vec)
- [x] First successful component (session-card.blade.php)

### Milestone 2: Architecture Refinement ✓ (COMPLETED)
**Status:** Done

- [x] **v0.4.0:** Embrace Laravel Boost (dropped Context-Manager)
- [x] **v0.4.2:** Hybrid architecture (local reasoning + Kimi K2.5 API)
- [x] Defined model split (Dev-Manager/Code-Reviewer local, Fullstack-Dev API)
- [x] Architecture documentation updated

### Milestone 3: Core Skills Development (In Progress)
**Status:** In Progress

| Skill | Purpose | Priority |
|-------|---------|----------|
| **handoff-tool** | Session/agent handoff for continuation | High |
| **commit-tool** | Quality gates before git operations | High |
| **wrapup-tool** | End-of-session ritual | Medium |
| **insights-tool** | Correction tracking + analytics | Medium |
| **memory-tool** | SQLite + FTS5 for learnings | Medium |

### Milestone 4: Agent Implementation ✓ (COMPLETED)
**Status:** Done

| Agent | Role | Model | Provider | Status |
|-------|------|-------|----------|--------|
| **Dev-Manager** | Orchestrator | gpt-oss-20b | Local | ✅ Working |
| **Fullstack-Dev** | Scaffold Engineer | kimi-k2.5 | API (Zen) | ✅ Working |
| **Code-Reviewer** | Quality Assistant | gpt-oss-20b | Local | ✅ Working |

### Milestone 5: Integration Testing ✓ (COMPLETED)
**Status:** Done

- [x] Build blog posts CRUD feature end-to-end
- [x] Test agent handoff flow
- [x] Verify Boost MCP integration
- [x] **31 passing tests**

### Milestone 6: What's Next
**Status:** Planning

- [ ] Add authorization to posts (users can only edit their own)
- [ ] Add image upload support
- [ ] Improve Dev-Manager to reduce unnecessary subagent spawning
- [ ] Create commit-tool for quality gates
- [ ] Test handoff-tool for session continuation
- [ ] Add more features to blog (tags, search, rich text)

---

## Architecture Evolution

```
v0.1.0  Initial modular refactor
v0.2.0  Task graphs, Debug-Agent
v0.3.0  Pivot to assistive, RAG-powered Context-Manager
v0.3.1  Model stack defined (qwen3-30b + gpt-oss-20b)
v0.4.0  Embrace Laravel Boost, drop Context-Manager
v0.4.1  FAILED - DeepSeek R1 crash, VRAM issues
v0.4.2  Hybrid architecture (local reasoning + Kimi K2.5 API) ✅ COMPLETED
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
| v0.4.1 | Try DeepSeek R1 orchestrator | Reasoning model for planning (FAILED) |
| v0.4.2 | Hybrid architecture | Local reasoning + Kimi K2.5 API for heavy lifting |
| v0.4.2 | Dev-Manager = gpt-oss-20b | Lightweight orchestration stays local |
| v0.4.2 | Fullstack-Dev = Kimi K2.5 | MoE strength via API, pay-as-you-go |
| v0.4.2 | Privacy priority | Project context local, only scaffolding sent to API |

---

## Dependencies

### External

| Tool | Purpose | Status |
|------|---------|--------|
| **Laravel Boost MCP** | Framework context | Available |
| **LMStudio** | Local reasoning models (gpt-oss-20b) | Configured |
| **OpenCode Zen** | API for Kimi K2.5 scaffolding | Account configured |
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

---

## Success Metrics

| Metric | Target | Actual |
|--------|--------|--------|
| Handoff resume time | <5 minutes | - |
| Scaffold accuracy | >80% without correction | ✅ 100% (blog feature) |
| Agent handoff success | 100% (no context loss) | ✅ Working |
| API cost per feature | <$0.50 average | ~$0.15-0.30 |
| Local reasoning uptime | 100% (Dev-Manager + Code-Reviewer) | ✅ Working |

---

*Roadmap is a living document. Update as progress is made.*
