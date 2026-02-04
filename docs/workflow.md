# Workflow Documentation

> **DEPRECATED:** This document references v0.2.x architecture. Pending rewrite for v0.3.0.

How the Agent Agency coordinates to complete web development tasks.

## The Coordination Model

```
┌─────────────────────────────────────────────────────────────────┐
│                      USER REQUEST                                │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                 DEVELOPMENT-MANAGER                              │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  • Load context files                                           │
│  • Analyze request and detect pattern                           │
│  • Build task dependency graph                                  │
│  • Execute graph with agents                                    │
│  • Validate delivery                                            │
└─────────────────────────────────────────────────────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│    BACKEND    │    │   FRONTEND    │    │    DEBUG      │
│   DEVELOPER   │    │   DEVELOPER   │    │    AGENT      │
└───────────────┘    └───────────────┘    └───────────────┘
          │                   │                   │
          └───────────────────┼───────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    DELIVERED SOLUTION                            │
└─────────────────────────────────────────────────────────────────┘
```

## Context Loading

Before any work, agents load context files:

| Agent | Context Files |
|-------|--------------|
| Development-Manager | project/architecture.md, laravel/conventions.md, laravel/patterns.md |
| Backend-Developer | laravel/conventions.md, laravel/patterns.md |
| Frontend-Developer | frontend/conventions.md, project/architecture.md |
| Debug-Agent | All context files |

## Task Dependency Graph

Development-Manager builds explicit task graphs based on pattern detection.

### Pattern Detection

```
Request → Analyze → MVC or API? → Build Graph → Execute
```

### Graph Types

#### Sequential (MVC CRUD)
```
Task 1: Backend (migration, model, controller)
  ↓
Task 2: Debug-Agent (validate backend)
  ↓
Task 3: Frontend (views, components)
  ↓
Task 4: Debug-Agent (full validation)
```

#### Hybrid (API + Admin UI)
```
Task 1: Backend (shared: migration, model)
  ↓
Task 2a: Backend (API: resources, routes) ─┐
Task 2b: Frontend (Admin UI)              ├─ Parallel
  ↓                                         │
Task 3: Debug-Agent (integration) ←───────┘
```

#### Parallel (Independent Tasks)
```
Task 1: Backend (config) ─┐
Task 2: Frontend (assets) ├─ Parallel
Task 3: Backend (setup)  ─┘
  ↓
Task 4: Debug-Agent (system validation)
```

## Workflow Patterns

### Standard MVC Feature

**Request:** "Create a blog posts feature"

1. **Development-Manager** loads context, detects MVC pattern
2. **Task Graph:** Backend → Verify → Frontend → Verify
3. **@backend-developer** creates:
   - Migration: `create_posts_table`
   - Model: `Post` with $fillable, $casts
   - Controller: `PostController` with CRUD methods
   - Routes: `routes/web.php`
4. **@debug-agent** validates:
   - `php artisan migrate:fresh` runs
   - `php artisan route:list` shows routes
   - PHP syntax check passes
5. **@frontend-developer** creates:
   - Blade views: `posts/index`, `posts/show`, etc.
   - Form components if needed
6. **@debug-agent** validates:
   - Pages load (200 OK)
   - Tailwind uses design tokens
   - No PHP code in Blade files

### API Feature

**Request:** "Create a REST API for users"

1. **Development-Manager** loads context, detects API pattern
2. **Task Graph:** Backend → Verify → Resources → Verify
3. **@backend-developer** creates:
   - Migration, Model
   - Controller with API methods only
   - Routes in `routes/api.php`
4. **@debug-agent** validates migrations and routes
5. **@backend-developer** creates:
   - API Resources for User
6. **@debug-agent** validates:
   - Endpoints return correct JSON structure
   - CRUD operations work via curl

### Hybrid Feature

**Request:** "User authentication (API + login page)"

1. **Development-Manager** detects hybrid pattern
2. **Task Graph:**
   - Task 1: Backend (users table, migrations)
   - Task 2a: Backend (API auth endpoints)
   - Task 2b: Frontend (login page)
   - Task 3: Debug-Agent (integration)
3. **Execution:** Task 1 → Tasks 2a & 2b in parallel → Task 3

## Agent Communication

### Spawning Backend-Developer

```markdown
@backend-developer Create a [FEATURE] with:

**Pattern:** MVC | API
**Requirements:**
- Migration for [table]
- Model with $fillable and $casts
- Controller with [methods]
- Routes in [routes/api.php | routes/web.php]

After completing, wait for @debug-agent validation.
```

### Spawning Frontend-Developer

```markdown
@frontend-developer Create [FEATURE] UI with:

**Pattern:** MVC | Livewire
**Backend Dependencies:** Endpoints created by backend-developer

**Requirements:**
- [Blade components | Livewire component]
- Tailwind CSS with design tokens
- [List | Create | Edit | Delete] functionality

After completing, wait for @debug-agent validation.
```

### Spawning Debug-Agent

```markdown
@debug-agent Validate the following work:

**Type:** Backend | Frontend | Integration
**Task:** Description
**Commands:**
- `php artisan migrate`
- Test specific functionality

Provide:
- Pass/Fail status
- Issues found (with file paths)
- Recommended fixes
```

## Quality Gates

### Backend Validation
- [ ] Migrations run without errors
- [ ] Models have $fillable and $casts
- [ ] Controllers follow RESTful conventions
- [ ] Routes properly defined
- [ ] PHP syntax valid

### Frontend Validation
- [ ] Blade files exist with correct names
- [ ] Valid Blade syntax (no PHP code)
- [ ] Tailwind uses design tokens
- [ ] Pages load (200 OK)
- [ ] Components render correctly

### Integration Validation
- [ ] Full CRUD workflow works
- [ ] Data flows between backend and frontend
- [ ] No console errors
- [ ] Links and assets load correctly

## Common Patterns

### MVC Controller

```php
// Controller
public function index()
{
    $items = Item::latest()->paginate(10);
    return view('items.index', compact('items'));
}

public function store(Request $request)
{
    $validated = $request->validate([
        'title' => 'required|string|max:255',
    ]);

    Item::create($validated);

    return redirect()->route('items.index')
        ->with('success', 'Item created.');
}
```

### API Controller

```php
// Controller
public function index()
{
    return ItemResource::collection(Item::all());
}

public function store(StoreItemRequest $request)
{
    $item = Item::create($request->validated());
    return new ItemResource($item);
}
```

### Blade Component

```blade
{{-- resources/views/components/card.blade.php --}}
@props([
    'title' => required_string(),
    'variant' => 'primary',
])

<div class="bg-body-light rounded-lg shadow-base p-4 border border-border">
    <h3 class="text-body-color font-medium mb-2">{{ $title }}</h3>
    {{ $slot }}
</div>
```

### Livewire Component

```php
// Component
class ItemManager extends Component
{
    #[Prop]
    public $items = [];

    public $title;

    protected $rules = ['title' => 'required|string|max:255'];

    public function render()
    {
        return view('livewire.item-manager');
    }

    public function save()
    {
        $this->validate();
        Item::create(['title' => $this->title]);
        $this->title = '';
        $this->items = Item::all();
    }
}
```

## Error Handling

1. **Backend fails validation**
   - Debug-Agent reports specific issues
   - Development-Manager respawns backend-developer with fix instructions

2. **Frontend can't integrate**
   - Verify backend is complete and validated
   - Check API endpoints match expected format
   - Frontend-developer requests clarification if needed

3. **Pattern misdetection**
   - Development-Manager asks for clarification
   - Defaults to MVC pattern for server-rendered, API for headless

## Scaling the Agency

### Adding New Agents

1. Create agent file: `.opencode/agents/{agent-name}.md`
2. Define context files needed
3. Add to Development-Manager's spawn list
4. Update ARCHITECTURE.md

### Parallel Execution

Development-Manager identifies independent tasks:

```markdown
Tasks 2 and 3 are independent and can run in parallel.
Spawning @backend-developer and @frontend-developer now.
```

## Testing Commands Reference

```bash
# Project navigation
cd ~/projects/agency-tests

# Migrations
php artisan migrate:fresh --seed
php artisan migrate:fresh --path=database/migrations/[file].php

# Routes
php artisan route:list
php artisan route:list --name=[route_name]

# Cache
php artisan config:clear
php artisan route:clear
php artisan view:clear

# PHP syntax
php -l app/Models/[Model].php
php -l app/Http/Controllers/[Controller].php

# Server test
php artisan serve --port=8000 &
curl -I http://localhost:8000/[route]

# API test
curl -X GET http://localhost:8000/api/[endpoint]
curl -X POST http://localhost:8000/api/[endpoint] -H "Content-Type: application/json" -d '{}'
```
