# config/initializers/counter_culture.rb

# Configure Counter Culture
Rails.application.config.after_initialize do
  # You can add global counter culture configuration here
  # Example:
  # CounterCulture.config do |config|
  #   config.counter_cache_name = ->(relation) { "#{relation}_count" }
  # end
end