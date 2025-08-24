# app/models/application_record.rb
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Available gem mixins for models:
  #
  # PgSearch (PostgreSQL full-text search):
  #   include PgSearch::Model
  #   pg_search_scope :search_by_title, against: [:title, :content]
  #
  # ActsAsParanoid (soft deletes):
  #   acts_as_paranoid column: :deleted_at
  #
  # Counter Culture (counter caches):
  #   counter_culture :parent, column_name: :children_count
  #
  # ActiveRecord Import (bulk operations):
  #   Model.import(records, validate: true) # Uses global config
  #
  # Ransack (searching/filtering):
  #   # Automatically available - no setup needed
  #   Model.ransack(name_cont: "search")
end
