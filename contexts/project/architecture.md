# Project Context

## Application: Agency Tests (Laravel 12)

### Tech Stack
- **Backend:** Laravel 12, SQLite database
- **Frontend:** Tailwind CSS v4, Blade components, Livewire
- **Editor:** OpenCode with LMStudio (qwen3-14b)
- **Package Manager:** Composer, NPM

### Current Features
- Session management (session-card component)
- Demo page with Tailwind theme

### File Structure
```
agency-tests/
├── app/
│   ├── Http/
│   │   └── Controllers/
│   ├── Livewire/
│   │   └── SessionCard.php
│   ├── Models/
│   │   └── Session.php
│   └── Providers/
├── bootstrap/
├── config/
├── database/
│   ├── migrations/
│   └── seeders/
├── public/
├── resources/
│   ├── css/
│   │   └── app.css (Tailwind theme)
│   └── views/
│       ├── components/
│       │   └── session-card.blade.php
│       ├── front-page.blade.php
│       └── livewire/
├── routes/
│   ├── api.php
│   ├── console.php
│   └── web.php
├── storage/
├── tests/
├── artisan
├── composer.json
└── package.json
```

## Development Guidelines

### Architecture Decisions

#### When to Use MVC Pattern
- Server-rendered pages
- Simple CRUD operations
- Quick prototyping
- SEO-required pages

#### When to Use API Pattern
- Mobile app backend
- SPA frontend consumption
- Third-party integrations

#### When to Use Livewire
- Interactive UI with minimal JavaScript
- Real-time updates
- Complex form handling

### Workflow Pattern

#### Standard MVC Feature Flow
```
1. Create Migration
2. Create Model with fillable/casts
3. Create Controller
4. Create Blade Views
5. Add Routes
6. Test in Browser
```

#### API Feature Flow
```
1. Create Migration
2. Create Model
3. Create Resource
4. Create Controller (API methods only)
5. Add API Routes
6. Test with curl/Postman
```

#### Livewire Feature Flow
```
1. Create Migration
2. Create Model
3. Create Livewire Component
4. Create Blade View for Component
5. Add Route (optional, for standalone pages)
6. Embed in existing page or use standalone
```

### Code Review Checklist

Before marking complete, verify:

#### Backend
- [ ] Migrations are reversible (down() method works)
- [ ] Models have proper $fillable and $casts
- [ ] Controllers follow RESTful conventions
- [ ] Validation is handled (Form Request or inline)
- [ ] API Resources transform data correctly

#### Frontend
- [ ] Tailwind classes use design tokens
- [ ] Components follow the card/form patterns
- [ ] Forms have proper labels and error handling
- [ ] No PHP code in Blade files
- [ ] Livewire components have proper lifecycle methods

#### General
- [ ] No nested Laravel projects
- [ ] No emoji in filenames
- [ ] Files are in correct locations
- [ ] Routes are properly named
- [ ] Code passes basic linting

### Common Patterns

#### Index Page (MVC)
```php
// Controller
public function index()
{
    $items = Item::latest()->paginate(10);
items.index', compact    return view('('items'));
}

// Route
Route::get('/items', [ItemController::class, 'index'])->name('items.index');

// Blade
@forelse($items as $item)
    {{ $item->name }}
@empty
    <p>No items found.</p>
@endforelse
```

#### Form Handling (MVC)
```php
// Controller
public function store(Request $request)
{
    $validated = $request->validate([
        'name' => 'required|string|max:255',
    ]);

    Item::create($validated);

    return redirect()->route('items.index')
        ->with('success', 'Item created.');
}

// Blade Form
<form action="{{ route('items.store') }}" method="POST">
    @csrf
    <!-- form fields -->
</form>
```

#### API Endpoint
```php
// Controller
public function index()
{
    return ItemResource::collection(Item::all());
}

// Route
Route::get('/items', [ItemController::class, 'index']);

// Resource
return [
    'id' => $this->id,
    'name' => $this->name,
    'created_at' => $this->created_at->toIso8601String(),
];
```

#### Livewire Component
```php
// Component
class ItemManager extends Component
{
    public $items;
    public $name;

    public function render()
    {
        return view('livewire.item-manager');
    }

    public function save()
    {
        $this->validate(['name' => 'required']);
        Item::create(['name' => $this->name]);
        $this->name = '';
        $this->items = Item::all();
    }
}

// Embed in Blade
@livewire('item-manager')
```

## Testing Commands

```bash
# Run migrations
php artisan migrate

# Clear config cache
php artisan config:clear

# Clear route cache
php artisan route:clear

# View routes
php artisan route:list

# Run tinker
php artisan tinker

# Seed database
php artisan db:seed
```

## Notes

- Always check `pwd` before running Laravel commands
- Use `php artisan` for all Laravel operations
- Tailwind v4 uses `@theme` directive for configuration
- Livewire components live in `app/Livewire/`
- Blade components in `resources/views/components/`
- API routes in `routes/api.php` are stateless
- Web routes in `routes/web.php` have session middleware
