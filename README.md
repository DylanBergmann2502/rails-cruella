# Rails Cruella

This is an opinionated Rails boilerplate designed as a comprehensive Rails API starter for REST API applications.

[![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)](https://rubyonrails.org/)
[![StandardRB](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

License: MIT

## Techstack

### Backend

- `Rails API` (API-only mode)
- `ActiveRecord` (ORM)
- `Rodauth` (Authentication with Argon2 password hashing)
- `Blueprinter` (JSON serialization)
- `Ransack` (Advanced filtering)
- `Pagy` (Pagination)

### Infrastructure & Services

- `PostgreSQL` (Database)
- `Redis` + `Sidekiq` (Background jobs and queueing)
- `S3/SeaweedFS` (File storage)
- `CORS` support for cross-origin requests

### Development & Quality

- `StandardRB` (Code formatting and linting)
- `Brakeman` (Security analysis)
- `RSpec` (Testing framework)
- `RSwag` (API documentation with Swagger)
- `Health Check` (Application monitoring)

## Basic Commands

### Installation

- Make sure you have `docker` and `docker compose` installed:

    ```sh
    docker --version
    docker compose version
    ```

- Set up the project for the first time (developing on `WSL` or `Linux` is **required** - Windows native is not supported):

    ```sh
    chmod +x ./bin/setup
    chmod +x ./bin/run
    ./bin/setup
    ```

- **Note**: Unlike Django Hans, Rails Cruella only supports Linux/WSL environments. No `.bat` files are provided for Windows native development.

- Have a look at `./bin/run` as it contains many shortcuts for ease of development as well as `./bin/setup` for setting up your project unanimously across team members.

## Useful Commands

- To start up the development server, run:

    ```sh
    docker compose -f deploy/local/web.yml up --build --remove-orphans
    ```

- To run `rails` command, use:

    ```sh
    docker compose -f deploy/local/web.yml run --rm rails bundle exec rails <command>
    ```

- To access `rails` console, run:

    ```sh
    docker compose -f deploy/local/web.yml run --rm rails bundle exec rails console
    ```

- To run database migrations, run:

    ```sh
    docker compose -f deploy/local/web.yml run --rm rails bundle exec rails db:migrate
    ```

- To format Ruby code with `StandardRB`, run:

    ```sh
    docker compose -f deploy/local/web.yml run --rm rails bundle exec standardrb --fix .
    ```

- To run security analysis with `Brakeman`, run:

    ```sh
    docker compose -f deploy/local/web.yml run --rm rails bundle exec brakeman
    ```

- To run tests with `RSpec`, run:

    ```sh
    docker compose -f deploy/local/web.yml run --rm rails bundle exec rspec
    ```

## Notes

- You should generate new secrets for env variables in `deploy/local/.envs` and `deploy/production/.envs`.

- This is an API-only Rails application. No frontend framework is included, and no nginx is used in production - Rails serves directly.

- The project mirrors the Docker-first approach of Django Hans but is tailored specifically for Rails API development with Linux/WSL support only.
