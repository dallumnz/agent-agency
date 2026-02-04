# Frontend Conventions

## Tailwind CSS v4 with Bootstrap Tokens

### Design System Colors

```css
:root {
  /* Primary - Brand color */
  --color-primary-50: #f0f9ff;
  --color-primary-100: #e0f2fe;
  --color-primary-500: #0284c7;
  --color-primary-600: #0284c7; /* Default */
  --color-primary-700: #0369a1;
  --color-primary-900: #0c4a6e;

  /* Success - Positive actions */
  --color-success: #65a30d;
  --color-success-light: #ecfccb;

  /* Warning - Caution */
  --color-warning: #d97706;
  --color-warning-light: #fef3c7;

  /* Info - Informational */
  --color-info: #0891b2;
  --color-info-light: #cffafe;

  /* Danger - Error/Delete */
  --color-danger: #dc2626;
  --color-danger-light: #fee2e2;

  /* Neutral */
  --color-body: #f0f2f5;
  --color-body-light: #f6f7f9;
  --color-text: #2c3034;
  --color-text-muted: #6c757d;
  --color-border: #e9ecef;
}
```

### Tailwind Theme Configuration

```css
@import "tailwindcss";

@theme {
  --color-primary-50: var(--color-primary-50);
  --color-primary-100: var(--color-primary-100);
  --color-primary-500: var(--color-primary-500);
  --color-primary-600: var(--color-primary-600);
  --color-primary-700: var(--color-primary-700);
  --color-primary-900: var(--color-primary-900);

  --color-success: var(--color-success);
  --color-success-light: var(--color-success-light);

  --color-warning: var(--color-warning);
  --color-warning-light: var(--color-warning-light);

  --color-info: var(--color-info);
  --color-info-light: var(--color-info-light);

  --color-danger: var(--color-danger);
  --color-danger-light: var(--color-danger-light);

  --color-body: var(--color-body);
  --color-body-light: var(--color-body-light);

  --color-text: var(--color-text);
  --color-text-muted: var(--color-text-muted);

  --color-border: var(--color-border);

  --radius-base: 4px;
  --radius-lg: 8px;

  --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
  --shadow-base: 0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1);
  --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);

  --transition-base: 200ms;
}
```

### Utility Classes Usage

```html
<!-- Colors -->
<div class="bg-primary-600 text-white">Primary button</div>
<div class="bg-success text-white">Success button</div>
<div class="bg-warning text-white">Warning button</div>
<div class="bg-danger text-white">Danger button</div>

<!-- Backgrounds -->
<div class="bg-body">Main background</div>
<div class="bg-body-light">Card/form background</div>

<!-- Text -->
<p class="text-body-color">Body text</p>
<p class="text-text-muted">Muted text</p>

<!-- Borders -->
<div class="border border-border">Card with border</div>

<!-- Rounded -->
<div class="rounded-base">Default rounded</div>
<div class="rounded-lg">Larger rounded</div>

<!-- Shadows -->
<div class="shadow-sm">Small shadow</div>
<div class="shadow-base">Default shadow</div>
<div class="shadow-lg">Card shadow</div>

<!-- Transitions -->
<button class="transition-base hover:bg-primary-700">Smooth transition</button>
```

## Component Pattern

### Blade Component Structure
```php
<?php

namespace App\View\Components;

use Illuminate\View\Component;

class SessionCard extends Component
{
    public function __construct(
        public string $title,
        public ?string $description = null,
        public string $status = 'active',
    ) {}

    public function render()
    {
        return view('components.session-card');
    }
}
```

### Blade Component View
```blade
{{-- resources/views/components/session-card.blade.php --}}
@props([
    'title' => required_string(),
    'description' => null,
    'status' => 'active',
])

<div class="bg-body-light rounded-lg shadow-base p-4 border border-border">
    <div class="flex items-center justify-between">
        <h3 class="text-body-color font-medium">{{ $title }}</h3>

        @if($status === 'active')
            <span class="px-2 py-1 text-xs font-medium rounded-base bg-success-light text-success">
                Active
            </span>
        @elseif($status === 'pending')
            <span class="px-2 py-1 text-xs font-medium rounded-base bg-warning-light text-warning">
                Pending
            </span>
        @endif
    </div>

    @if($description)
        <p class="mt-2 text-text-muted text-sm">{{ $description }}</p>
    @endif

    {{ $slot }}
</div>
```

### Livewire Component Structure
```php
<?php

namespace App\Livewire;

use Livewire\Component;
use App\Models\Todo;

class TodoManager extends Component
{
    public $todos;
    public $title;
    public $description;

    protected $rules = [
        'title' => 'required|string|max:255',
        'description' => 'nullable|string',
    ];

    public function mount()
    {
        $this->todos = Todo::latest()->get();
    }

    public function render()
    {
        return view('livewire.todo-manager');
    }

    public function create()
    {
        $this->validate();

        Todo::create([
            'title' => $this->title,
            'description' => $this->description,
        ]);

        $this->reset(['title', 'description']);
        $this->todos = Todo::latest()->get();
    }

    public function delete(Todo $todo)
    {
        $todo->delete();
        $this->todos = Todo::latest()->get();
    }
}
```

### Livewire Component View
```blade
{{-- resources/views/livewire/todo-manager.blade.php --}}
<div class="space-y-4">
    <form wire:submit="create" class="space-y-3">
        <div>
            <label for="title" class="block text-sm font-medium text-body-color">Title</label>
            <input
                type="text"
                wire:model="title"
                id="title"
                class="mt-1 block w-full rounded-base border-border shadow-sm focus:border-primary-500 focus:ring-primary-500"
                placeholder="Enter todo title"
            >
            @error('title') <span class="text-danger text-sm">{{ $message }}</span> @enderror
        </div>

        <button
            type="submit"
            class="w-full bg-primary-600 text-white py-2 px-4 rounded-base hover:bg-primary-700 transition-base"
        >
            Add Todo
        </button>
    </form>

    <div class="space-y-2">
        @foreach($todos as $todo)
            <div class="flex items-center justify-between bg-body-light p-3 rounded-base shadow-sm">
                <span class="text-body-color">{{ $todo->title }}</span>
                <button
                    wire:click="delete({{ $todo->id }})"
                    class="text-danger hover:text-danger/80 transition-base"
                >
                    Delete
                </button>
            </div>
        @endforeach
    </div>
</div>
```

## Forms

### Form Field Pattern
```blade
<div class="space-y-1">
    <label for="field_name" class="block text-sm font-medium text-body-color">
        Field Label
    </label>
    <input
        type="text"
        name="field_name"
        id="field_name"
        class="block w-full rounded-base border-border shadow-sm focus:border-primary-500 focus:ring-primary-500"
    >
    <p class="text-sm text-text-muted">Helper text</p>
</div>
```

### Button Styles
```blade
<!-- Primary -->
<button class="bg-primary-600 text-white py-2 px-4 rounded-base hover:bg-primary-700 transition-base">
    Primary Action
</button>

<!-- Secondary -->
<button class="bg-body-light text-body-color py-2 px-4 rounded-base border border-border hover:bg-body transition-base">
    Secondary
</button>

<!-- Danger -->
<button class="bg-danger text-white py-2 px-4 rounded-base hover:bg-danger/90 transition-base">
    Delete
</button>

<!-- Icon Button -->
<button class="p-2 text-text-muted hover:text-body-color transition-base">
    <svg class="w-5 h-5">...</svg>
</button>
```

## Card Pattern
```blade
<div class="bg-body-light rounded-lg shadow-base p-4 border border-border">
    <h3 class="text-lg font-medium text-body-color mb-2">Card Title</h3>
    <p class="text-text-muted">Card content goes here.</p>
</div>
```
