# config/initializers/pagy.rb

# Set the default pagination limit
Pagy.options[:limit] = 25

# Set up overflow handling
Pagy.options[:overflow] = :last_page
