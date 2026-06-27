# Gemfile
source "https://rubygems.org"

# Core Framework
gem "rails", "~> 8.1.3"

# Database & Storage
gem "pg", "~> 1.6"
gem "redis", "~> 5.4"
gem "aws-sdk-s3", require: false

# Web Server & Performance
gem "puma", "~> 8.0"
gem "bootsnap", require: false
gem "thruster", require: false

# Background Jobs
gem "sidekiq", "~> 8.1"
gem "sidekiq-cron", "~> 2.4"

# Authentication & Authorization
gem "rodauth-rails", "~> 2.1"
gem "pundit", "~> 2.5"
gem "argon2", "~> 2.3", require: false
gem "jwt", "~> 3.2", require: false
gem "sequel-activerecord_connection", "~> 2.0", require: false
gem "tilt", "~> 2.7", require: false

# API & Serialization
gem "dry-validation", "~> 1.11"
gem "rack-cors"
gem "blueprinter", "~> 1.3"

# Search & Filtering
gem "pg_search", "~> 2.3"
gem "ransack", "~> 4.4"
gem "pagy", "~> 43.5"

# Model Utilities
gem "counter_culture", "~> 3.14"
gem "acts_as_paranoid", "~> 0.11"
gem "activerecord-import", "~> 2.2"

# API Documentation
gem "rswag", "~> 2.17"

# Deployment & Monitoring
gem "kamal", require: false

# Platform-specific
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  # Debugging
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "meta_request", "~> 0.8"

  # Code Quality & Analysis
  gem "brakeman", require: false
  gem "standard", require: false

  # Development Utilities
  # gem "annotate"

  # Testing Framework
  gem "rspec-rails", "~> 8.0"

  # Test Data & Factories
  gem "factory_bot_rails", "~> 6.5"
  gem "faker", "~> 3.8"

  # Test Utilities
  gem "shoulda-matchers", "~> 7.0"
  gem "webmock", "~> 3.26"
end
