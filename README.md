# Rails Cruella

An opinionated Rails boilerplate for REST API development.

[![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)](https://rubyonrails.org/)
[![StandardRB](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

License: MIT

## Tech Stack

### Backend
- **Rails API** — API-only mode
- **Rodauth** — authentication with Argon2 password hashing
- **ActiveRecord** + **PostgreSQL**
- **Sidekiq** + **Redis** — background jobs with cron scheduling
- **Ransack** — advanced filtering
- **Pagy** — pagination
- **Blueprinter** — JSON serialization

### Infrastructure
- **Garage** — S3-compatible object storage
- **RSwag** — Swagger API docs
- **Brakeman** — security analysis
- **StandardRB** — formatter + linter
- **RSpec** — test suite

## Service URLs (local)

| Service | URL |
|---|---|
| Rails API | http://localhost:8000 |
| Swagger UI | http://localhost:8000/api-docs |
| Sidekiq Web UI | http://localhost:4567 |
| Garage S3 API | http://localhost:3900 |
| Garage Web UI | http://localhost:3909 |

## Setup

Requires `docker` and `docker compose`.

```sh
docker --version
docker compose version
```

**Unix (WSL, Linux):**

```sh
chmod +x ./bin/setup ./bin/run
./bin/setup
```

The `./bin/setup` script pulls images, runs migrations, initializes the Garage bucket, and starts all services. See `./bin/run` for all available dev shortcuts.

## Common Commands

All commands route through `./bin/run`:

### Lifecycle

```sh
./bin/run start        # Build and start all services
./bin/run stop         # Stop containers
./bin/run down         # Stop and remove containers
./bin/run logs         # Tail container logs
```

### Rails

```sh
./bin/run rails <command>    # Run any Rails command
./bin/run console            # Rails console
./bin/run generate <args>    # Rails generators
./bin/run migrate            # Run migrations
./bin/run rollback [steps]   # Rollback migrations
./bin/run seed               # Seed the database
./bin/run reset              # Reset the database
```

### Code Quality

```sh
./bin/run rspec [options]    # Run tests
./bin/run format [paths]     # StandardRB format
./bin/run lint [paths]       # StandardRB lint
./bin/run brakeman           # Security analysis
```

### Background Jobs

```sh
./bin/run sidekiq web        # Start Sidekiq Web UI
```

## Notes

- Generate fresh secrets for `deploy/local/.envs/` and `deploy/production/.envs/` before running.
- API-only application — no frontend, no nginx in production. Rails serves directly.
- WSL or Linux required. Windows native is not supported.
