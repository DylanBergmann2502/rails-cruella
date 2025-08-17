# config/initializers/sidekiq.rb

require "sidekiq"
require "sidekiq/web"
require "sidekiq/cron"

Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL", "redis://redis:6379/0"),
    network_timeout: 5
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL", "redis://redis:6379/0"),
    network_timeout: 5
  }
end

# Configure Sidekiq Web UI
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_rails_cruella_session"

# Load cron jobs from schedule.yml
Rails.application.config.after_initialize do
  schedule_file = Rails.root.join("config", "schedule.yml")

  if File.exist?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end
