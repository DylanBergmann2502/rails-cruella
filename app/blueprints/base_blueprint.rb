# app/blueprints/base_blueprint.rb
class BaseBlueprint < Blueprinter::Base
  # Common fields and configurations that all blueprints should have
  identifier :id

  # Standard timestamps
  fields :created_at, :updated_at

  # Helper method for paginated responses
  def self.paginated(collection, pagy)
    {
      data: render_as_hash(collection),
      pagination: {
        page: pagy.page,
        pages: pagy.pages,
        count: pagy.count,
        items: pagy.limit,
        prev: pagy.prev,
        next: pagy.next
      }
    }
  end
end
