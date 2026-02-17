# Personal Portfolio & Learning Platform

> A comprehensive personal website showcasing Python software development, data engineering, and ML/DL projects with hands-on learning across DevOps, web development, databases, and modern tooling.

## 🎯 Project Vision

This is not just a portfolio website—it's a **1000+ hour learning journey** (3 hours/day × 1 year) to master modern software development through practical implementation.

## 🚀 Technology Stack

Subject to change as I explore and learn, but the current plan includes:

### Core
- **Backend**: Django 6.0+ (Python)
- **Frontend**: HTML, CSS (TailwindCSS), JavaScript (Plotly, interactive components)
- **Databases**: PostgreSQL (primary), Redis (caching), exploration of NoSQL options
- **ML/DL**: scikit-learn, TensorFlow, Keras

### Infrastructure & DevOps
- **Hosting**: TBD (evaluating DigitalOcean, Vercel, Cloudflare)
- **CI/CD**: GitHub Actions
- **Containerization**: Docker, DevContainers
- **Message Queue**: Apache Pulsar (or alternatives)

### Development Tools
- **IDE**: VSCode with GitHub Copilot
- **Version Control**: Git + GitHub
- **Code Quality**: Linters, formatters, pre-commit hooks integrated with GitHub Actions

## 📚 Learning Domains

1. **Web Development**: Django full-stack (ORM, Auth, Admin, Forms, Routing, Templates, REST APIs)
2. **DevOps**: Linux, Docker, CI/CD, monitoring, deployment automation
3. **Data Engineering**: ETL pipelines, data visualization, streaming
4. **ML/DL**: Model training, deployment, integration with web apps
5. **Database Design**: SQL optimization, schema design, NoSQL patterns
6. **Security**: Authentication, RBAC, HTTPS/TLS, secure coding practices
7. **APIs**: RESTful design, GraphQL exploration
8. **Frontend**: Modern CSS, interactive visualizations, simple games

## 📂 Project Structure

This structure is designed to keep the project organized as it grows, and will evolve and change as I iterate.

```
my-site/
├── .devcontainer/       # Development container configuration
├── .github/             # GitHub Actions workflows
├── .vscode/             # VSCode settings and extensions
├── docs/                # Project documentation
│   ├── ROADMAP.md       # Detailed learning roadmap
│   ├── HOSTING.md       # Domain, VPS, DNS, certificates guide
│   ├── DJANGO_LEARNING.md  # Django concepts tracker
│   └── PROGRESS.md      # Weekly/monthly progress logs
├── src/                 # Django project root
├── requirements/        # Python dependencies (dev, prod, etc.)
├── scripts/             # Utility scripts
├── tests/               # Test suites
└── docker-compose.yml   # Local development environment
```

## 🎓 Learning Philosophy

- **Depth over breadth**: Master fundamentals before moving to advanced topics
- **Build to learn**: Create POCs and mini-projects for each Django concept
- **Document everything**: Blog posts written while building the blog feature itself
- **Iterate and refactor**: Re-implement features as knowledge grows
- **No shortcuts**: Experience the "why" behind best practices

## 🗓️ Project Phases

See [ROADMAP.md](docs/ROADMAP.md) for the detailed 12-month learning plan.

### Phase 1 (Months 1-2): Foundation
- Domain & hosting setup
- Django basics & project structure
- Development environment (DevContainers, CI/CD basics)
- First simple apps

### Phase 2 (Months 3-4): Core Web Development
- Django ORM mastery
- Authentication & authorization (RBAC)
- REST APIs with Django REST Framework
- Database design & optimization

### Phase 3 (Months 5-6): Data & Visualization
- Data visualization with Plotly/D3.js
- Integration with open datasets
- GeoLockation features (GeoDjango)
- Streamlit-like interactive apps

### Phase 4 (Months 7-8): ML/DL Integration
- scikit-learn model deployment
- TensorFlow/Keras integration
- Model serving APIs
- Real-time predictions

### Phase 5 (Months 9-10): Advanced Features
- Message queues (Apache Pulsar)
- Real-time features (WebSockets/Channels)
- Advanced caching strategies
- Performance optimization

### Phase 6 (Months 11-12): Production & Polish
- Security hardening
- Monitoring & logging
- SEO optimization
- Portfolio refinement

## 🚦 Getting Started

1. **Environment Setup**: See [docs/SETUP.md](docs/SETUP.md)
2. **First Steps**: Follow [docs/QUICKSTART.md](docs/QUICKSTART.md)
3. **Current Sprint**: Check [docs/PROGRESS.md](docs/PROGRESS.md)

## 📖 Documentation

- [Roadmap & Learning Plan](docs/ROADMAP.md)
- [Hosting & Infrastructure Guide](docs/HOSTING.md)
- [Django Learning Tracker](docs/DJANGO_LEARNING.md)
- [Development Workflow](docs/DEVELOPMENT.md)
- [Architecture Decisions](docs/ADR.md)

## 📝 License

MIT License - feel free to use this as a template for your own learning journey.

---

**📊 Current Progress**: See [docs/PROGRESS.md](docs/PROGRESS.md) for detailed status, time tracking, and progress logs.
