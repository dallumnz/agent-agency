# Context Index

This file maps agent requests to the context files they need.

## Development-Manager

When planning work, load:
- `contexts/project/architecture.md` — Project structure and workflow
- `contexts/laravel/conventions.md` — Code style and naming
- `contexts/laravel/patterns.md` — MVC vs API decisions

## Backend-Developer

When implementing backend:
- `contexts/laravel/conventions.md` — Controller/Model/Migration patterns
- `contexts/laravel/patterns.md` — Pattern selection (MVC/API)
- `contexts/project/architecture.md` — Project structure

## Frontend-Developer

When implementing frontend:
- `contexts/frontend/conventions.md` — Tailwind and component patterns
- `contexts/project/architecture.md` — Integration points

## Context Loading Pattern

### Before Planning (Development-Manager)
```bash
# Load these files into prompt:
1. contexts/project/architecture.md
2. contexts/laravel/conventions.md
3. contexts/laravel/patterns.md
```

### Before Backend Work (Backend-Developer)
```bash
# Load these files into prompt:
1. contexts/laravel/conventions.md
2. contexts/laravel/patterns.md
3. contexts/project/architecture.md (if feature-specific context needed)
```

### Before Frontend Work (Frontend-Developer)
```bash
# Load these files into prompt:
1. contexts/frontend/conventions.md
2. contexts/project/architecture.md
```

## Quick Reference

| Agent | Context Files |
|-------|---------------|
| Development-Manager | architecture.md, conventions.md, patterns.md |
| Backend-Developer | conventions.md, patterns.md |
| Frontend-Developer | frontend/conventions.md, architecture.md |
| Debug-Agent | All context files for validation |

## Adding New Context

When adding new context:

1. Create file in appropriate directory (`laravel/`, `frontend/`, `project/`)
2. Add to this index with description
3. Update relevant agent definitions if needed

## Example: Adding API Context

1. Create `contexts/laravel/api.md`
2. Add to this index:
   ```markdown
   ### API-Specific
   - `contexts/laravel/api.md` — RESTful conventions, API Resources
   ```
3. Backend-Developer loads it when implementing API features
