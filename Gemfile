# Gemfile
source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.6"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.6.1"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"
# Use Redis adapter to run Action Cable in production
gem "redis", ">= 5.4.1"

# Use Sidekiq for background job processing [https://github.com/sidekiq/sidekiq]
gem "sidekiq", "~> 8.0"

# Use Sidekiq-cron for scheduled jobs [https://github.com/ondrejbartas/sidekiq-cron]
gem "sidekiq-cron", "~> 2.3"

# Use Rodauth for authentication [https://rodauth.jeremyevans.net/]
gem "rodauth-rails", "~> 2.1"

# Enables Sequel to use Active Record's database connection
gem "sequel-activerecord_connection", "~> 2.0", require: false

# Used by Rodauth for password hashing
gem "argon2", "~> 2.3", require: false

# Used by Rodauth for JWT support
gem "jwt", "~> 3.1", require: false

# Used by Rodauth for rendering built-in view and email templates
gem "tilt", "~> 2.6", require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use AWS SDK for S3/MinIO storage backend
gem "aws-sdk-s3", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors"

# Pagination with Pagy [https://github.com/ddnexus/pagy]
gem "pagy", "~> 9.4"

# PostgreSQL full-text search [https://github.com/Casecommons/pg_search]
gem "pg_search", "~> 2.3"

# Object-based searching [https://github.com/activerecord-hackery/ransack]
gem "ransack", "~> 4.2"

# Counter cache management [https://github.com/magnusvk/counter_culture]
gem "counter_culture", "~> 3.9"

# Soft delete functionality [https://github.com/ActsAsParanoid/acts_as_paranoid]
gem "acts_as_paranoid", "~> 0.10"

# Bulk import for ActiveRecord [https://github.com/zdennis/activerecord-import]
gem "activerecord-import", "~> 1.8"

# Fast JSON:API serializer [https://github.com/procore/blueprinter]
gem "blueprinter", "~> 1.0"

# Comprehensive health check for production [https://github.com/ianheggie/health_check]
gem "health_check", "~> 3.1"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Ruby code formatter and linter [https://github.com/testdouble/standard]
  gem "standard", require: false

  # RSpec testing framework [https://github.com/rspec/rspec-rails]
  gem "rspec-rails", "~> 8.0"

  # Factory Bot for test data creation [https://github.com/thoughtbot/factory_bot_rails]
  gem "factory_bot_rails", "~> 6.5"

  # Faker for generating fake data [https://github.com/faker-ruby/faker]
  gem "faker", "~> 3.5"

  # Shoulda Matchers for RSpec [https://github.com/thoughtbot/shoulda-matchers]
  gem "shoulda-matchers", "~> 6.5"

  # WebMock for stubbing HTTP requests [https://github.com/bblimke/webmock]
  gem "webmock", "~> 3.25"

  # RSwag for API documentation [https://github.com/rswag/rswag]
  gem "rswag", "~> 2.16"

  # Rails Panel for Chrome extension debugging [https://github.com/dejan/rails_panel]
  gem "meta_request", "~> 0.8"
end
