# sidekiq_web_config.ru
require "sidekiq"
require "sidekiq/web"
require "securerandom"
require "rack/session"

# Configure Redis connection for standalone Sidekiq Web
Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL", "redis://redis:6379/0"),
    network_timeout: 5
  }
end

# Add Basic Authentication (optional, like Flower)
if ENV["SIDEKIQ_USERNAME"] && ENV["SIDEKIQ_PASSWORD"]
  use Rack::Auth::Basic, "Sidekiq Web" do |username, password|
    username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end
end

# Add session middleware for CSRF protection
use Rack::Session::Cookie,
  secret: ENV.fetch("SIDEKIQ_SESSION_SECRET", SecureRandom.hex(32)),
  same_site: true,
  max_age: 86400

run Sidekiq::Web
