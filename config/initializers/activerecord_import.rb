# config/initializers/activerecord_import.rb

# Configure ActiveRecord Import globally
Rails.application.config.after_initialize do
  if defined?(ActiveRecord::Import)
    # Set default options for all bulk imports
    ActiveRecord::Import.configure do |config|
      # Global default options
      config.default_options = {
        validate: true,                    # Validate records before import
        timestamps: true,                  # Set created_at/updated_at
        on_duplicate_key_update: {         # Handle duplicates
          conflict_target: [:id],
          columns: :all
        }
      }
    end
  end
end
