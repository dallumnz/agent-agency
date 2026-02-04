# Laravel Patterns

## MVC Pattern (Traditional)

### When to Use
- Server-rendered pages
- Laravel Blade templates
- Livewire components
- Simple CRUD with UI
- SEO-critical pages

### Structure
```
app/Http/Controllers/[Name]Controller.php
resources/views/[kebab-case]/[action].blade.php
routes/web.php (web middleware)
```

### Example: Todo List (MVC)
```
Controller: TodoController
  - index() → returns view('todos.index')
  - create() → returns view('todos.create')
  - store(Request) → validates, creates, redirects
  - edit(Todo) → returns view('todos.edit')
  - update(Request, Todo) → validates, updates, redirects
  - destroy(Todo) → deletes, redirects

Views:
  - resources/views/todos/index.blade.php
  - resources/views/todos/create.blade.php
  - resources/views/todos/edit.blade.php
  - resources/views/todos/show.blade.php
```

### Livewire Pattern
```
Component: app/Livewire/TodoManager.php
  - mount() → load initial data
  - render() → returns view('livewire.todo-manager')
  - create() → method to create
  - delete(Todo) → method to delete

View: resources/views/livewire/todo-manager.blade.php
```

## API Pattern

### When to Use
- Mobile app backend
- SPA frontend (React, Vue, etc.)
- Third-party integrations
- Headless architecture

### Structure
```
app/Http/Controllers/[Name]Controller.php
app/Http/Resources/[Name]Resource.php
routes/api.php (api middleware, stateless)
```

### Example: Todo API
```
Controller: TodoController
  - index() → TodoResource::collection(Todo::all())
  - store(StoreTodoRequest) → new TodoResource(Todo::create())
  - show(Todo) → new TodoResource($todo)
  - update(StoreTodoRequest, Todo) → $todo->update()
  - destroy(Todo) → $todo->delete()

Routes: Route::apiResource('todos', TodoController::class)
```

## Decision Tree

### Feature Request → Architecture Decision

```
What type of application?
├── Server-rendered pages?
│   └── Yes → MVC Pattern
│       ├── Simple CRUD? → Blade + Controller
│       └── Interactive? → Livewire
│
└── API needed?
    └── Yes → API Pattern
        ├── Mobile app? → Full CRUD API
        ├── SPA? → RESTful API
        └── Third-party? → Custom endpoints
```

### Quick Reference

| Feature Type | Pattern | Route File | Return Type |
|--------------|---------|------------|-------------|
| Web page | MVC | web.php | view() |
| Livewire component | MVC | web.php | view() |
| Public API | API | api.php | JsonResource |
| Auth endpoints | Both | Both | JWT/Session |
| Webhooks | API | api.php | response()->json() |

## Repository Pattern (Optional)

For complex applications, abstract data access:

```
app/Repositories/
├── TodoRepositoryInterface.php
├── EloquentTodoRepository.php
└── CachedTodoRepository.php

Service Layer:
app/Services/
└── TodoService.php
```

## When to Use Which

### Use MVC When:
- Building traditional Laravel application
- SEO is important
- Simple CRUD operations
- Quick prototyping
- Team is familiar with Blade

### Use API When:
- Mobile app consumer
- JavaScript frontend (React/Vue)
- Need to share data structure
- Scalability requirements
- Multiple clients

### Use Mixed When:
- Admin panel (MVC) + mobile app (API)
- Some pages Blade, some SPA
- Gradual migration from MVC to SPA

## Best Practices

1. **Be consistent** — Pick a pattern per feature, stick with it
2. **Use Form Requests** — Keep validation out of controllers
3. **Use Resources** — Transform API responses consistently
4. **Use Actions** — Laravel 8+ action classes for complex logic
5. **Keep controllers thin** — Delegate to services/jobs
