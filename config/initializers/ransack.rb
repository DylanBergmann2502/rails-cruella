# config/initializers/ransack.rb
Ransack.configure do |config|
  # Raise errors when unknown predicates are used
  config.ignore_unknown_conditions = false

  # Add custom predicates if needed
  # config.add_predicate "title_starts_with", :arel_predicate => "matches", :formatter => proc { |v| "#{v}%" }

  # Prevent potentially sensitive associations from being searched by default
  # You can add specific associations to this list as needed
  # config.sanitize_default_select = true

  # Prevent potentially sensitive custom ransackers from being exposed
  # config.hide_sort_order_indicators = true
end
