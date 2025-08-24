# config/initializers/blueprinter.rb

# Configure Blueprinter for JSON serialization
Blueprinter.configure do |config|
  # Set the default transform method to camelCase for API consistency
  config.generator = Oj if defined?(Oj)

  # Optional: Set a default datetime format
  config.datetime_format = proc { |datetime| datetime&.iso8601 }

  # Optional: Enable association extensions
  config.sort_fields_by = :definition
end
