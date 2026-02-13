# Agent Agency Roadmap

**Version:** 0.5.0
**Last Updated:** 2026-02-13
**Stack:** OpenCode + Laravel Boost MCP + Hybrid LLMs (Local + API)

---

## Vision

Build an AI-powered development assistant that:
- Follows explicit workflow (no skipping)
- Versions all architecture decisions
- Provides traceable code reviews
- Uses hybrid local + API models for optimal performance/cost
- Runs primarily on local infrastructure with API backup

---

## Version History

```
v0.1.0  Initial modular refactor
v0.2.0  Task graphs, Debug-Agent
v0.3.0  Pivot to assistive, RAG-powered Context-Manager
v0.4.0  Embrace Laravel Boost, drop Context-Manager
v0.4.1  FAILED - DeepSeek R1 crash, VRAM issues
v0.4.2  Hybrid architecture (local + API) ✅
v0.5.0  Explicit workflow, architecture versioning, code reviews ✅
v0.6.0  Next iteration
```

---

## Milestones

### Milestone 1: Foundation ✅

**Status:** Completed

- [x] Define architecture
- [x] Establish model stack
- [x] Set up LMStudio configuration
- [x] First successful component

### Milestone 2: Architecture Refinement ✅

**Status:** Completed (v0.4.0 - v0.4.2)

- [x] Embrace Laravel Boost
- [x] Hybrid architecture (local reasoning + Kimi K2.5 API)
- [x] Model split defined

### Milestone 3: Core Workflow ✅

**Status:** Completed (v0.5.0)

| Item | Status | Description |
|------|--------|-------------|
| Explicit steps | ✅ | Step 0 → Step 5 enforcement |
| ARCHITECTURE.md writing | ✅ | Senior-Architect MUST write |
| Architecture versioning | ✅ | version-architecture.sh + delete |
| Code reviews to file | ✅ | documentation/code-reviews/ |
| Handoff generation | ✅ | python scripts/handoff.py |
| MCP removal | ✅ | Bash scripts instead |

### Milestone 4: Agent Implementation ✅

**Status:** Completed

| Agent | Role | Model | Status |
|-------|------|-------|--------|
| Dev-Manager | Orchestrator | gpt-oss-20b (local) | ✅ Working |
| Senior-Architect | System Design | gpt-oss-20b (local) | ✅ Working |
| Fullstack-Dev | Implementation | kimi-k2.5 (API) | ✅ Working |
| Code-Reviewer | Quality | kimi-k2.5 (API) | ✅ Working |

### Milestone 5: Next (v0.6.0)

**Status:** Planning

- [ ] Test handoff resume workflow
- [ ] Commit-tool for quality gates
- [ ] Insights-tool for correction tracking
- [ ] Multi-project orchestration
- [ ] CI/CD integration

---

## Key Decisions

| Version | Decision | Rationale |
|---------|----------|-----------|
| v0.4.0 | Drop Context-Manager | Laravel Boost covers framework context |
| v0.4.2 | Hybrid architecture | Local reasoning + API for heavy lifting |
| v0.5.0 | Explicit workflow | Prevents skipping steps |
| v0.5.0 | Bash over MCP | Simpler, more reliable |
| v0.5.0 | Delete ARCHITECTURE.md | Ensures fresh copy each feature |

---

## Dependencies

### External (Configured)

| Tool | Purpose | Status |
|------|---------|--------|
| Laravel Boost MCP | Framework context | ✅ Available |
| LMStudio | Local models (gpt-oss-20b) | ✅ Configured |
| OpenCode Zen | API for Kimi K2.5 | ✅ Account configured |
| OpenCode | Agent platform | ✅ In use |

### Internal (Implemented)

| Component | Status |
|-----------|--------|
| version-architecture.sh | ✅ Working |
| handoff.py | ✅ Working |
| documentation/code-reviews/ | ✅ Working |
| documentation/handoffs/ | ✅ Working |

---

## Success Metrics

| Metric | Target | Actual |
|--------|--------|--------|
| Workflow completion | 100% | ✅ Validated |
| Architecture written | 100% | ✅ Enforced |
| Code reviews filed | 100% | ✅ File-based |
| Handoff generated | 100% | ✅ Bash-based |

---

*Roadmap is a living document. Update as progress is made.*
