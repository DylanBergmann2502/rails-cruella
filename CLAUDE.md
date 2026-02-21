# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Rails Cruella is a Rails API-only boilerplate. No frontend, no nginx — Rails serves directly. It mirrors conventions from the Django Hans project at `/mnt/c/Users/locdu/OneDrive/Desktop/utils/starter/django_hans`.

## Code Style

- **String literals**: Always use double quotes (`""`)
- **File path comments**: Every file must have a comment at the top with its path (e.g., `# app/controllers/health_controller.rb`)
- **Linter**: StandardRB (not RuboCop)

## Development Environment

Ruby is not installed on the host. All Rails/Ruby commands must run through Docker containers via `./bin/run`. The default environment is `local`; prefix with `ENV=production` for production.

### Common Commands

```sh
./bin/run start              # Build and start all services (--build --remove-orphans)
./bin/run stop               # Stop containers
./bin/run down               # Stop and remove containers
./bin/run logs               # Tail logs

./bin/run rails <command>    # Any rails command
./bin/run console            # Rails console
./bin/run generate <args>    # Rails generators
./bin/run migrate            # db:migrate
./bin/run rollback [steps]   # db:rollback
./bin/run seed               # db:seed
./bin/run reset              # db:reset

./bin/run rspec [options]    # Run tests (e.g., ./bin/run rspec spec/requests/auth_spec.rb)
./bin/run swagger            # Regenerate swagger/v1/swagger.json from rswag specs
./bin/run format [paths]     # StandardRB --fix
./bin/run lint [paths]       # StandardRB (no fix)
./bin/run brakeman           # Security analysis

./bin/run bundle <command>   # bundle commands
./bin/run sidekiq web        # Start Sidekiq Web UI on port 4567
```

### Adding Gems

When adding new gems, delete `Gemfile.lock` and rebuild containers (`./bin/run start`).

### Environment Files

`.envs` directories are hidden from Claude by default — verify their location with `ls`. Docker Compose files use relative paths: `env_file: - ./.envs/.rails` (relative to the compose file at `deploy/local/web.yml`). Build context is `../..` (project root).

## Architecture

### Request Flow

```
HTTP Request → Rodauth middleware (JWT auth) → Rails Router → Controller → Blueprinter response
```

### Directory Layout

- `app/controllers/` — API controllers. `ApplicationController` includes `Pagy::Method` and `Pundit::Authorization`. Use `before_action :authenticate` to require auth; `current_user` returns the authenticated `Account`.
- `app/blueprints/` — Blueprinter serializers. Inherit from `BaseBlueprint` (includes `id`, `created_at`, `updated_at`). Use `BaseBlueprint.paginated(collection, pagy)` for paginated responses.
- `app/policies/` — Pundit authorization policies. Inherit from `ApplicationPolicy`.
- `app/jobs/` — Sidekiq background jobs. Inherit from `ApplicationJob`. Cron schedules defined in `config/schedule.yml`.
- `app/misc/` — Rodauth configuration. `rodauth_main.rb` is the primary auth config; `rodauth_app.rb` mounts it.
- `app/models/` — ActiveRecord models. `Account` is the user model (managed by Rodauth).
- `spec/requests/` — RSwag specs that double as both tests and Swagger doc generation.

### Authentication

Rodauth with JWT + Argon2 password hashing. Features enabled: `create_account`, `login`, `logout`, `jwt`, `jwt_refresh`, `close_account`, `argon2`. Tokens: 15-minute access tokens, 7-day refresh tokens. All auth endpoints are at `/auth/*` (e.g., `/auth/login`, `/auth/jwt-refresh`). Accepts only JSON. JWT payload includes `account_id`.

The `Account` model uses a status enum: `unverified: 1`, `verified: 2`, `closed: 3`.

### Controllers

Protect endpoints with `before_action :authenticate`. For paginated responses, use pagy then `BaseBlueprint.paginated(collection, pagy)`. Blueprinter serializes datetimes as ISO 8601.

```ruby
def index
  pagy, records = pagy(Model.all)
  render json: ModelBlueprint.paginated(records, pagy)
end
```

`ApplicationRecord` has opt-in mixins (not auto-included): `PgSearch`, `ActsAsParanoid`, `CounterCulture`, `ActiveRecord::Import`. Add only what a model needs.

### Health Checks

`GET /health` — combined check (503 if any fail). Individual: `/health/database`, `/health/redis`, `/health/sidekiq`, `/health/s3`. S3 check is skipped in dev unless `USE_S3_STORAGE=true`.

### Swagger / API Docs

RSwag specs in `spec/requests/` serve dual purpose: they run as tests and generate the OpenAPI spec. Docs available at `/api-docs` (Swagger UI) and `/api/redoc` (ReDoc). After adding a new spec, regenerate the swagger file with:

```sh
./bin/run swagger
```

### Background Jobs

Sidekiq + Redis. Cron jobs configured in `config/schedule.yml` (sidekiq-cron format). Sidekiq Web UI runs as a separate service on port 4567 (`sidekiq_web_config.ru`).

### File Storage

Garage (S3-compatible). AWS SDK is used with a region placeholder. Configuration in `config/initializers/aws_sdk.rb` and `config/storage.yml`.

### Key Gems

| Concern | Gem |
|---|---|
| Serialization | blueprinter |
| Pagination | pagy |
| Filtering | ransack, pg_search |
| Validation | dry-validation |
| Soft delete | acts_as_paranoid |
| Bulk insert | activerecord-import |
| Counter cache | counter_culture |
| Auth | rodauth-rails + jwt + argon2 |
| Authorization | pundit |

### Service URLs (local)

| Service | URL |
|---|---|
| Rails API | http://localhost:8000 |
| Swagger UI | http://localhost:8000/api-docs |
| ReDoc | http://localhost:8000/api/redoc |
| OpenAPI JSON | http://localhost:8000/api-docs/v1/swagger.json |
| Sidekiq Web UI | http://localhost:4567 |
| Garage S3 API | http://localhost:3900 |
| Garage Web UI | http://localhost:3909 |

## Setup

```sh
chmod +x ./bin/setup ./bin/run
./bin/setup   # pulls images, runs migrations, initializes Garage bucket, starts services
```

Generate fresh secrets for `deploy/local/.envs/` and `deploy/production/.envs/` before first run.
