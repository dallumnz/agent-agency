# Agent Agency v0.5.0

A collection of OpenCode-native agents for hybrid web development using local + API models.

## Overview

An "agency" of specialized AI agents that build web applications following a team-based workflow with explicit step-by-step execution:

1. **Dev-Manager** — Orchestrates workflow (local: gpt-oss-20b)
2. **Senior-Architect** — System design, writes ARCHITECTURE.md (local: gpt-oss-20b)
3. **Fullstack-Dev** — Implementation (API: Kimi K2.5)
4. **Code-Reviewer** — Quality gate, writes reviews to file (local: gpt-oss-20b)

## Workflow (v0.5.0)

```
Step 0: Delegate to @senior-architect
Step 1: Verify ARCHITECTURE.md was written
Step 2: Delegate to @fullstack-dev → then @code-reviewer
Step 4a: Run version-architecture.sh (snapshot + delete ARCHITECTURE.md)
Step 4b: Generate handoff document
Step 5: Deliver result
```

### Critical Rules

- **Senior-Architect MUST write ARCHITECTURE.md** — Non-negotiable
- **Dev-Manager MUST complete ALL steps** — No skipping
- **version-architecture.sh deletes ARCHITECTURE.md** — Ensures fresh copy for next feature
- **Code-Reviewer writes to file** — documentation/code-reviews/[FEATURE]-[DATE].md
- **Handoff generated via bash** — python scripts/handoff.py

## Architecture

```
User Request
    ↓
Dev-Manager (orchestrator)
    ├── Step 0: @senior-architect → writes ARCHITECTURE.md
    ├── Step 2: @fullstack-dev → implements
    ├── Step 3: @code-reviewer → writes review to file
    ├── Step 4a: bash version-architecture.sh
    ├── Step 4b: python handoff.py generate
    ↓
Result + Handoff + Review
```

### Model Strategy

| Agent | Role | Model | Provider | Cost |
|-------|------|-------|----------|------|
| Dev-Manager | Orchestrator | gpt-oss-20b | LMStudio (local) | Free |
| Senior-Architect | System Design | gpt-oss-20b | LMStudio (local) | Free |
| Fullstack-Dev | Implementation | kimi-k2.5 | OpenCode Zen (API) | Pay-as-you-go |
| Code-Reviewer | Quality | gpt-oss-20b | LMStudio (local) | Free |

## Project Structure

```
agent-agency/
├── .opencode/
│   └── agents/
│       ├── development-manager.md   # Orchestrator with explicit workflow
│       ├── senior-architect.md     # System design, writes ARCHITECTURE.md
│       ├── fullstack-dev.md        # Implementation agent
│       └── code-reviewer.md         # Quality gate, writes to file
├── .opencode/scripts/
│   ├── version-architecture.sh     # Snapshots + deletes ARCHITECTURE.md
│   └── handoff.py                  # Generates handoff documents
├── documentation/
│   ├── architecture/
│   │   └── ARCHITECTURE_*.md      # Versioned snapshots
│   ├── code-reviews/
│   │   └── [FEATURE]-[DATE].md    # Code review documents
│   └── handoffs/
│       └── HANDOFF_*.md            # Handoff documents
├── skills/
│   └── handoff-tool/              # Session handoff skill
├── ARCHITECTURE.md                 # Source of truth (deleted after versioning)
├── README.md                       # This file
├── ROADMAP.md                      # Project roadmap
└── setup.sh                        # Setup script
```

## Key Features (v0.5.0)

### Explicit Workflow Enforcement
- Step 0 → Step 5 clearly defined
- Dev-Manager cannot skip steps
- "If you finish early, you have FAILED"

### Architecture Versioning
- Senior-Architect writes ARCHITECTURE.md
- version-architecture.sh snapshots to documentation/architecture/
- ARCHITECTURE.md is **deleted** after snapshot
- Ensures fresh ARCHITECTURE.md for every feature

### Code Review Workflow
- Code-Reviewer writes findings to documentation/code-reviews/
- Format: [FEATURE]-[YYYY-MM-DD].md
- Critical/Warning/Suggestion classification

### Handoff Generation
- python scripts/handoff.py generate
- Output: documentation/handoffs/HANDOFF_*.md
- Includes: completed items, next steps, git status

## Prerequisites

1. **OpenCode** — https://opencode.ai/download
2. **LMStudio** — https://lmstudio.ai/ with `gpt-oss-20b` loaded
3. **OpenCode Zen** — https://opencode.ai/auth (for Kimi K2.5 API)

## Quick Start

```bash
# Clone the repo
git clone https://github.com/dallumnz/agent-agency.git
cd agent-agency

# Copy agents to OpenCode
cp -r .opencode/agents/* ~/.opencode/agents/

# Configure LMStudio
# - Open LMStudio → Local Server
# - Select gpt-oss-20b
# - Start Server (http://localhost:1234)

# Start building
cd ~/projects/your-laravel-app
opencode --agent development-manager
```

## Agent Reference

### Dev-Manager

**Role:** Orchestrator

**Model:** `gpt-oss-20b` (local)

**Workflow:**
```
Step 0: Delegate to @senior-architect
Step 1: Verify ARCHITECTURE.md exists
Step 2: Delegate to @fullstack-dev → then @code-reviewer
Step 4a: Run version-architecture.sh
Step 4b: Generate handoff
Step 5: Deliver result
```

### Senior-Architect

**Role:** System Design

**Model:** `gpt-oss-20b` (local)

**Responsibility:**
- MUST write ARCHITECTURE.md (non-negotiable)
- Create implementation plan
- Document architecture decisions

### Fullstack-Dev

**Role:** Implementation

**Model:** `kimi-k2.5` (API)

**Responsibility:**
- Create migrations, models, controllers
- Build views, Livewire components
- Write tests
- Return to Dev-Manager

### Code-Reviewer

**Role:** Quality Gate

**Model:** `gpt-oss-20b` (local)

**Responsibility:**
- Review code for security, quality, style
- Classify issues: Critical/Warning/Suggestion
- Write review to documentation/code-reviews/[FEATURE]-[DATE].md

## Scripts

### version-architecture.sh

```bash
# Snapshot ARCHITECTURE.md and delete working copy
bash .opencode/scripts/version-architecture.sh
```

**Output:**
- documentation/architecture/ARCHITECTURE_YYYY-MM-DD.md
- ARCHITECTURE.md (deleted)

### handoff.py

```bash
# Generate handoff document
python .opencode/scripts/handoff.py generate \
    --path /path/to/project \
    --task "Feature Name" \
    --completed "Item 1" "Item 2" \
    --next-steps "Next Step"
```

**Output:**
- documentation/handoffs/HANDOFF_YYYY-MM-DD.md

## Success Metrics

| Metric | Target | Actual |
|--------|--------|--------|
| Workflow completion | 100% | In progress |
| Architecture written | 100% | Enforced |
| Code reviews filed | 100% | File-based |
| Handoff generated | 100% | Bash-based |

## Version History

- **v0.5.0** — Explicit workflow enforcement, architecture versioning, code review files
- **v0.4.3** — MCP handoff integrated
- **v0.4.2** — Hybrid architecture validated
- **v0.4.1** — FAILED (VRAM issues)
- **v0.4.0** — Embraced Laravel Boost

## License

MIT License — See LICENSE file for details.
