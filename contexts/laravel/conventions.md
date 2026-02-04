# Laravel Conventions

## File Naming Rules

### General Rules
- **Always use kebab-case:** `todo-list`, `user-profile`, `blog-post`
- **Always lowercase:** `todo-list.blade.php`, NOT `TodoList.blade.php`
- **No symbols:** No emojis (⚡), no underscores, no special characters
- **No prefixes/suffixes:** Just `todo-list.blade.php`, not `⚡todo-list.blade.php` or `component-todo-list.blade.php`

### Blade Components
- Format: `[kebab-case].blade.php`
- Location: `resources/views/components/` or `resources/views/livewire/`
- Examples:
  - `resources/views/components/todo-list.blade.php`
  - `resources/views/livewire/todo-form.blade.php`
  - `resources/views/users/user-card.blade.php`

### Livewire Components
- Class name: `TodoList` (PascalCase)
- File name: `todo-list.blade.php` (kebab-case, lowercase)
- Example:
  - Class: `App\Http\Livewire\TodoList`
  - File: `resources/views/livewire/todo-list.blade.php`

### Migration Files
- Format: `YYYY_MM_DD_HHMMSS_create_[plural-kebab-case]_table.php`
- Examples:
  - `2026_02_03_000000_create_todos_table.php`
  - `2026_02_03_000000_create_blog_posts_table.php`

### Route Files
- Web routes: `routes/web.php`
- API routes: `routes/api.php`
- Console routes: `routes/console.php`

### Resource Routes (Recommended)
For CRUD features, always use `Route::resource()` instead of manual routes:

```php
// routes/web.php
use App\Http\Controllers\TodoController;

Route::resource('todos', TodoController::class);
```

This generates standard CRUD routes:
| Method | URI | Action | Route Name |
|--------|-----|--------|------------|
| GET | /todos | index | todos.index |
| GET | /todos/create | create | todos.create |
| POST | /todos | store | todos.store |
| GET | /todos/{todo} | show | todos.show |
| GET | /todos/{todo}/edit | edit | todos.edit |
| PUT/PATCH | /todos/{todo} | update | todos.update |
| DELETE | /todos/{todo} | destroy | todos.destroy |

For API-only, use `Route::apiResource()` in `routes/api.php` (excludes create/edit routes).

## Naming Conventions

### Models
- Singular, PascalCase: `User`, `TodoItem`, `BlogPost`
- Table: Snake_case, plural: `users`, `todo_items`, `blog_posts`
- Primary key: `id` (unsigned bigint)
- Timestamps: `created_at`, `updated_at`

### Controllers
- Singular or Plural based on resource:
  - Resource CRUD: `UsersController`, `PostsController`
  - Single action: `HomeController`, `AuthController`
- Location: `app/Http/Controllers/`
- Extends: `App\Http\Controllers\Controller`
- Methods: `index`, `show`, `create`, `store`, `edit`, `update`, `destroy`

### Routes
- API: `routes/api.php` — `Route::apiResource()` or `Route::get('/todos', ...)`
- Web: `routes/web.php` — Named routes, web middleware
- Console: `routes/console.php`

### Migrations
- Format: `YYYY_MM_DD_HHMMSS_create_[table_name]_table.php`
- Columns: `id()`, `foreignId()`, `string()`, `text()`, `boolean()`, `timestamps()`

### Views
- Location: `resources/views/[kebab-case]/[action].blade.php`
- Example: `resources/views/todos/index.blade.php`
- Livewire: `resources/views/livewire/[kebab-case].blade.php`

### Services/Repositories
- Service: `app/Services/[Singular]Service.php`
- Repository: `app/Repositories/[Singular]Repository.php`

## Code Style

### Controller Pattern
```php
<?php

namespace App\Http\Controllers;

use App\Models\Todo;
use App\Http\Resources\TodoResource;
use Illuminate\Http\Request;

class TodoController extends Controller
{
    public function index()
    {
        $todos = Todo::latest()->get();
        return TodoResource::collection($todos);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
        ]);

        $todo = Todo::create($validated);

        return new TodoResource($todo);
    }

    public function destroy(Todo $todo)
    {
        $todo->delete();

        return response()->noContent();
    }
}
```

### Model Pattern
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Todo extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'description',
        'completed',
    ];

    protected $casts = [
        'completed' => 'boolean',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    // Relationships
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
```

### Migration Pattern
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('todos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('title');
            $table->text('description')->nullable();
            $table->boolean('completed')->default(false);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('todos');
    }
};
```

## API Resources
- Use API Resources for transformation: `php artisan make:resource TodoResource`
- Location: `app/Http/Resources/`
- Format: Return single resources or collections

```php
<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TodoResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'description' => $this->description,
            'completed' => $this->completed,
            'created_at' => $this->created_at->toIso8601String(),
            'updated_at' => $this->updated_at->toIso8601String(),
        ];
    }
}
```

## Form Requests (Validation)
- Use for complex validation: `php artisan make:request StoreTodoRequest`
- Location: `app/Http/Requests/`

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreTodoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'completed' => 'boolean',
        ];
    }
}
```
