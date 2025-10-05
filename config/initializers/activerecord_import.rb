# config/initializers/activerecord_import.rb

# Configure ActiveRecord Import globally
module ActiveRecordImportDefaults
  # Wrapper method that applies default options to all imports
  def import_with_defaults(records, options = {})
    default_options = {
      validate: true,           # Validate records before import
      timestamps: true,         # Set created_at/updated_at
      on_duplicate_key_update: { # Handle duplicates (Postgres/MySQL only)
        conflict_target: [:id],
        columns: :all
      }
    }

    # Merge user options with defaults (user options take precedence)
    merged_options = default_options.merge(options)

    # Call the original import method
    import(records, merged_options)
  end
end

# Extend ActiveRecord::Base with our defaults
ActiveSupport.on_load(:active_record) do
  extend ActiveRecordImportDefaults
end
