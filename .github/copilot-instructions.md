# GitHub Copilot Instructions for My-Site Project

## Project Context

You are assisting with a **year-long learning project** to build a comprehensive personal portfolio website. The developer is dedicating 1000+ hours to master web development, data engineering, ML/DL, and DevOps.

## Core Principles

1. **Educational Focus**: Prioritize learning over shortcuts. Explain the "why" behind suggestions.
2. **Django-First**: This is primarily a Django 6.0+ project. Python is the main language.
3. **Best Practices**: Always suggest industry-standard patterns and practices.
4. **Incremental Progress**: Support step-by-step implementation. Don't suggest overly complex solutions early on.
5. **Documentation**: Encourage commenting and documentation for future reference.

## Technology Stack

### Backend

- **Framework**: Django 6.0+ (latest stable)
- **Python Version**: 3.14+ (specify in suggestions)
- **Database**: PostgreSQL (primary), Redis (caching)
- **API**: Django REST Framework
- **Real-time**: Django Channels (for WebSockets)
- **Message Queue**: Apache Pulsar or alternatives

### Frontend

- **CSS Framework**: TailwindCSS
- **JavaScript Libraries**: Plotly for visualizations, vanilla JS preferred initially
- **Templates**: Django template language (Jinja2 syntax)

### ML/DL

- **Libraries**: scikit-learn, TensorFlow 2.x, Keras
- **Deployment**: TensorFlow Serving, custom Django views

### DevOps & Tools

- **Containerization**: Docker, docker-compose
- **CI/CD**: GitHub Actions
- **Development**: DevContainers (VSCode)
- **Code Quality**: Ruff (linter + formatter), Ty (type checker)
- **Package Management**: UV (modern workspace package manager)
- **Testing**: pytest, pytest-django, coverage

## Code Style Guidelines

### Python

- **Formatter & Linter**: Ruff (ultra-fast replacement for Black, isort, Flake8, Pylint)
  - Documentation: https://docs.astral.sh/ruff/
- **Type Checker**: Ty (modern Python type checking)
  - Documentation: https://docs.astral.sh/ty/
- **Package Manager**: UV (workspace package and project manager)
  - Documentation: https://docs.astral.sh/uv/
- **Type Hints**: Use type hints for function signatures
- **Docstrings**: Google style docstrings
- **Naming**:
  - Classes: PascalCase
  - Functions/variables: snake_case
  - Constants: UPPER_SNAKE_CASE

### Django Conventions

- **App Structure**: Keep apps focused and reusable
- **Models**: Use explicit `related_name` for foreign keys
- **Views**: Prefer class-based views (CBVs) for standard operations
- **URLs**: Use `path()` over `re_path()`, meaningful URL names
- **Settings**: Split settings (base, dev, prod) using `django-environ`

### JavaScript

- **Style**: ES6+, prefer `const`/`let` over `var`
- **Framework**: Vanilla JS initially, consider Alpine.js for reactivity
- **Modules**: Use ES modules when possible

## Suggestions Guidelines

### When Suggesting Code

1. **Explain First**: Briefly explain what the code does and why
2. **Show Examples**: Provide working examples, not just snippets
3. **Error Handling**: Include proper error handling and validation
4. **Security**: Highlight security considerations (CSRF, XSS, SQL injection)
5. **Testing**: Suggest test cases when appropriate

### For Django Specifically

- Reference official Django 6.0 documentation: https://docs.djangoproject.com/en/6.0/
- Suggest apps for common features (django-allauth for auth, django-debug-toolbar, etc.)
- Follow Django's "batteries included" philosophy
- Use Django's built-in features before third-party packages

### Learning Path Support

- When introducing new concepts, reference the relevant Django docs section
- Suggest progressive complexity (basic → intermediate → advanced)
- Recommend related exercises or POC ideas
- Link to Django's tutorial or topic guides when relevant

## Project-Specific Context

### Portfolio Features to Build

1. **Home/About Page**: Personal introduction, skills showcase
2. **Project Portfolio**: Gallery of projects with filters
3. **Blog**: Technical writing platform (markdown support, syntax highlighting)
4. **Data Visualizations**: Interactive dashboards with open datasets
5. **ML Demos**: Live model predictions, model explanations
6. **Web Games**: Simple interactive browser games
7. **Resume/CV**: Downloadable, printable format
8. **Contact Form**: With email notifications

### Django Learning Goals (from docs)

- Models & ORM (queries, aggregation, transactions)
- URL routing & views (CBV, FBV, async views)
- Templates & template tags
- Forms & validation
- Authentication & authorization
- Admin customization
- Static files & media handling
- Testing
- Security best practices
- Performance optimization
- GeoDjango (geographic framework)
- Internationalization
- Caching
- Signals
- Middleware
- Management commands
- REST APIs
- WebSockets/Channels

### Current Phase

Check [docs/PROGRESS.md](../docs/PROGRESS.md) for the current learning phase and active tasks.

## Common Patterns to Suggest

### Project Structure

```python
# Django app structure
my_app/
    __init__.py
    models.py          # Database models
    views.py           # View logic (or views/ directory for complex apps)
    urls.py            # URL patterns
    forms.py           # Django forms
    serializers.py     # DRF serializers (if using REST)
    admin.py           # Admin configuration
    apps.py            # App configuration
    tests/             # Test modules
        __init__.py
        test_models.py
        test_views.py
        test_forms.py
    templates/         # App-specific templates
        my_app/
            template.html
    static/            # App-specific static files
        my_app/
            css/
            js/
    management/        # Custom management commands
        commands/
```

### Django Model Example

```python
from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

class Post(models.Model):
    """Blog post model."""

    title = models.CharField(max_length=200)
    slug = models.SlugField(unique=True)
    author = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='posts'
    )
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    published = models.BooleanField(default=False)

    class Meta:
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['-created_at']),
        ]

    def __str__(self) -> str:
        return self.title
```

### Environment Variables

Always suggest using environment variables for:

- Secret keys
- Database credentials
- API keys
- Debug mode toggles
- Allowed hosts

Use `django-environ` or `python-decouple` for management.

## Don't Assume

- The developer is still learning—explain imports and dependencies
- Not all Django concepts are familiar yet—provide context
- Development environment may be incomplete—suggest setup steps
- Third-party packages may not be installed—mention installation

## Encourage

- Writing tests alongside features
- Documenting learnings in the blog
- Creating POCs for new Django concepts
- Refactoring as skills improve
- Asking questions and exploring alternatives

## Security Reminders

- Never commit secrets to Git
- Always use HTTPS in production
- Validate and sanitize user input
- Use Django's CSRF protection
- Set secure cookie flags in production
- Keep dependencies updated
- Use parameterized queries (ORM does this)

## Performance Tips

- Use `select_related()` and `prefetch_related()` for reducing queries
- Implement caching where appropriate
- Use database indexes strategically
- Optimize static file serving
- Consider async views for I/O-bound operations (Django 4.1+)

---

**Remember**: This is a learning journey. Prioritize understanding over speed. Every feature is an opportunity to explore Django's capabilities deeply.
