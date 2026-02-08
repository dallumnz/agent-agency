# Agent Agency v0.4.2

A collection of OpenCode-native agents for hybrid web development using local + API models.

## Overview

An "agency" of specialized AI agents that build web applications following a team-based workflow with hybrid local/API model architecture:

1. **Dev-Manager** — Plans work, coordinates agents (local: gpt-oss-20b)
2. **Fullstack-Dev** — Scaffolding, migrations, controllers (API: Kimi K2.5)
3. **Code-Reviewer** — Quality, security, static analysis (local: gpt-oss-20b)
4. **Senior-Architect** — System design, architecture diagrams (local: gpt-oss-20b)

## Architecture

```
User Request
    ↓
Dev-Manager (local reasoning)
    ├── Senior-Architect (system design) ──► Local Python scripts
    ├── Fullstack-Dev (scaffolding) ─────► Kimi K2.5 (API)
    └── Code-Reviewer (quality) ──────────► Local reasoning
    ↓
Result
```

### Model Strategy

| Agent | Role | Model | Provider | Cost |
|-------|------|-------|----------|------|
| Dev-Manager | Orchestrator | gpt-oss-20b | LMStudio (local) | Free |
| Fullstack-Dev | Scaffold Engineer | kimi-k2.5 | OpenCode Zen (API) | Pay-as-you-go |
| Code-Reviewer | Quality Assistant | gpt-oss-20b | LMStudio (local) | Free |
| Senior-Architect | System Design | gpt-oss-20b | LMStudio (local) | Free |

## Quick Start

### Prerequisites

1. **OpenCode** — https://opencode.ai/download
2. **LMStudio** — https://lmstudio.ai/ with `gpt-oss-20b` loaded
3. **OpenCode Zen** — https://opencode.ai/auth (for Kimi K2.5 API access)

### Step 1: Configure LMStudio

1. Open LMStudio → Local Server
2. Select `gpt-oss-20b`
3. Click **Start Server** (default: http://localhost:1234)

### Step 2: Install Agents

```bash
# Clone the repo
git clone https://github.com/yourusername/agent-agency.git
cd agent-agency

# Copy agents to OpenCode
cp -r .opencode/agents/* ~/.opencode/agents/

# Or run setup script
./setup.sh
```

### Step 3: Configure OpenCode Zen

1. Run `opencode` → `/connect`
2. Select "opencode" and sign in at https://opencode.ai/auth
3. Add API key and billing

### Step 4: Start Building

```bash
cd ~/projects/your-laravel-app
opencode --agent development-manager
```

## Agent Reference

### Dev-Manager

**Role:** Team lead, planner, coordinator

**Model:** `gpt-oss-20b` (local, LMStudio)

**What it does:**
- Analyzes requests and chooses right agent
- Uses Laravel Boost MCP for context
- Spawns workers: @fullstack-dev, @code-reviewer, @senior-architect
- Delivers consolidated results

### Fullstack-Dev

**Role:** Scaffold engineer

**Model:** `kimi-k2.5` (API, OpenCode Zen)

**What it does:**
- Creates migrations, models, controllers
- Builds Blade views and Livewire components
- Generates Pest tests
- Runs migrations

### Code-Reviewer

**Role:** Quality assistant

**Model:** `gpt-oss-20b` (local, LMStudio)

**What it does:**
- Static analysis
- Security review
- Code quality checks
- Performance suggestions

### Senior-Architect

**Role:** System design

**Model:** `gpt-oss-20b` (local, LMStudio)

**What it does:**
- Architecture diagrams (Mermaid, PlantUML, ASCII)
- Dependency analysis
- Technology recommendations
- Architecture Decision Records (ADRs)

## Project Structure

```
agent-agency/
├── .opencode/
│   └── agents/
│       ├── development-manager.md   # Orchestrator
│       ├── fullstack-dev.md         # Scaffold engineer
│       ├── code-reviewer.md         # Quality assistant
│       └── senior-architect.md       # System design
├── skills/
│   └── handoff-tool/              # Session handoff
├── handoffs/                       # Handoff documents
├── ARCHITECTURE.md                  # Full architecture docs
├── ROADMAP.md                       # Project roadmap
├── README.md                        # This file
└── setup.sh                        # Setup script
```

## Dependencies

### MCP Servers
- **Laravel Boost** — Framework context, migrations, Pest testing
- **Filesystem** — Project access

### External Services
- **OpenCode Zen** — Kimi K2.5 API for scaffolding
- **LMStudio** — Local reasoning models

### Local Tools
- **PHP/Laravel** — For Laravel projects
- **Python** — For senior-architect scripts

## Workflow Example

**Request:** "Build a blog posts feature"

1. **Dev-Manager** analyzes request → spawns @fullstack-dev
2. **Fullstack-Dev** (Kimi K2.5) creates:
   - Migration for posts table
   - Post model with relationships
   - PostsController
   - Blade views (index, show, create, edit)
   - Pest tests
3. **Code-Reviewer** reviews code → reports issues
4. **Dev-Manager** delivers complete feature

## Skills

### handoff-tool

Structured session and agent handoff for seamless continuation.

```bash
# Generate handoff
python skills/handoff-tool/scripts/handoff.py generate \
    --path /path/to/project \
    --task "Feature name" \
    --completed "Task 1" "Task 2" \
    --next-steps "Next step"

# Resume from handoff
python skills/handoff-tool/scripts/handoff.py resume \
    --file HANDOFF_2026-02-08.md
```

## Success Metrics

| Metric | Target | Actual |
|--------|--------|--------|
| Scaffold accuracy | >80% | ✅ 100% (blog feature) |
| Agent handoff success | 100% | ✅ Working |
| API cost per feature | <$0.50 | ~$0.15-0.30 |
| Local reasoning uptime | 100% | ✅ Working |

## License

MIT License — See LICENSE file for details.

## Contributing

Contributions welcome! See issues for:
- New agents
- Skill improvements
- Documentation fixes

## Version History

- **v0.4.2** — Hybrid architecture validated (local + API models)
- **v0.4.1** — FAILED (VRAM issues, DeepSeek R1 crash)
- **v0.4.0** — Embraced Laravel Boost, dropped Context-Manager
- **v0.3.x** — Early iterations with various model stacks
