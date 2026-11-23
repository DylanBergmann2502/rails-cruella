# config/initializers/pagy.rb

# Set the default pagination limit
Pagy::OPTIONS[:limit] = 25

# Set up overflow handling
Pagy::OPTIONS[:overflow] = :last_page
