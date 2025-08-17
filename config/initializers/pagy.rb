# config/initializers/pagy.rb
require "pagy/extras/bootstrap"
require "pagy/extras/overflow"

# Pagy::DEFAULT[:page]   = 1
# Pagy::DEFAULT[:limit]  = 25
# Pagy::DEFAULT[:size]   = 9

# Set the default pagination limit
Pagy::DEFAULT[:limit] = 25

# Optional: Set up overflow handling
Pagy::DEFAULT[:overflow] = :last_page

# Optional: Bootstrap support for frontend
# Pagy::DEFAULT[:bootstrap] = true