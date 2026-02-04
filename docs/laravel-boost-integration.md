# Laravel Boost + Agent Agency Integration

> **DEPRECATED:** This document references v0.2.x architecture. Pending rewrite for v0.3.0.

## Overview

**Laravel Boost** is an official Laravel package that provides 15 MCP (Model Context Protocol) tools for AI-assisted development. It works seamlessly with OpenCode and our Agent Agency.

## Setup in Your Project

```bash
cd ~/projects/agency-tests
composer require laravel/boost --dev
php artisan boost:install
```

## Available Boost Tools

| Tool | Purpose | Agent Use |
|------|---------|-----------|
| `application-info` | PHP/Laravel versions, packages, models | Frontend: Understand app structure |
| `database-schema` | Complete DB schema with analysis | Frontend: Match component patterns |
| `database-queries` | Execute queries directly | Backend: Verify data structures |
| `list-routes` | Analyze application routes | Orchestrator: Understand navigation |
| `artisan-commands` | List available commands | Any agent: Run migrations, etc. |
| `tinker` | Execute code in Laravel context | Debugging, testing snippets |
| `config-get` | Get configuration values | Frontend: Match app settings |
| `docs-search` | Query Laravel docs API | Any agent: Look up syntax |
| `application-logs` | Read error logs | Debugging issues |
| `browser-logs` | Read browser console errors | Debugging frontend issues |

## Integration with Agent Agency

### Orchestrator
- Uses `application-info` to understand project structure
- Uses `list-routes` to map navigation
- Uses `docs-search` for Laravel best practices

### Design Agent
- Uses `database-schema` to understand data models
- Uses `application-info` to see installed packages

### Frontend Agent
- Uses `database-schema` to match form fields to tables
- Uses `config-get` to match color/spacing settings
- Uses `docs-search` for Blade/Livewire syntax

## Example Workflow

**Request:** "Create a user profile card component"

1. **Orchestrator** calls `application-info` → sees Inertia + Tailwind
2. **Orchestrator** calls `database-schema` → sees User model with name, email, avatar
3. **Design Agent** analyzes existing components (via file read)
4. **Frontend Agent** creates component matching app patterns:
   ```blade.php
   <x-card>
       <x-slot:header>
           <img src="{{ $user->avatar }}" class="w-16 h-16 rounded-full">
       </x-slot:header>
       <h3>{{ $user->name }}</h3>
       <p>{{ $user->email }}</p>
   </x-card>
   ```

## OpenCode + Boost + Agent Agency

```
┌─────────────────────────────────────────────────────────────┐
│ OpenCode                                                     │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │ Orchestrator │  │ Design Agent │  │ Frontend Agent│      │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘       │
│         │                 │                 │                │
│         └────────┬────────┴────────┬────────┘                │
│                  │                 │                         │
│                  ▼                 ▼                         │
│         ┌─────────────────────────────────────────┐          │
│         │         Laravel Boost MCP Tools         │          │
│         │  • application-info  • database-schema  │          │
│         │  • list-routes       • docs-search      │          │
│         │  • config-get        • artisan-commands │          │
│         └─────────────────────────────────────────┘          │
│                           │                                   │
│                           ▼                                   │
│                   ┌──────────────┐                           │
│                   │  LMStudio    │                           │
│                   │  (Local AI)  │                           │
│                   └──────────────┘                           │
└─────────────────────────────────────────────────────────────┘
```

## Quick Test

```bash
cd ~/projects/agency-tests

# List available Boost commands
php artisan boost

# Test MCP tools via OpenCode
opencode --model lmstudio/qwen3-14b "Use Boost to list all routes in this Laravel app"
```

## Resources

- **Laravel Boost Docs:** https://laravel.com/ai/boost
- **MCP Integration:** Configure in OpenCode settings to enable Boost tools
- **Agent Agency:** ~/projects/agent-agency/
