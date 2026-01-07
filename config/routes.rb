# config/routes.rb
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api/docs"
  mount Rswag::Api::Engine => "/api/docs"

  # Convenience redirects for common swagger paths
  get "/swagger", to: redirect("/api/docs")
  get "/api/swagger", to: redirect("/api/docs")

  # ReDoc endpoint for alternative API documentation
  get "/api/redoc", to: "redoc#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Custom health check endpoints
  # Available endpoints:
  # GET /health or /health/all - All checks (database, redis, sidekiq, s3)
  # GET /health/database - Database connectivity only
  # GET /health/redis - Redis connectivity only
  # GET /health/sidekiq - Sidekiq processes check
  # GET /health/s3 - S3 connectivity only
  get "health", to: "health#all"
  get "health/all", to: "health#all"
  get "health/database", to: "health#database"
  get "health/redis", to: "health#redis"
  get "health/sidekiq", to: "health#sidekiq"
  get "health/s3", to: "health#s3"

  # Simple /up endpoint for basic load balancer checks
  # Returns 200 if the app boots with no exceptions, otherwise 500
  get "up", to: "rails/health#show", as: :rails_health_check

  # Rodauth authentication endpoints - mount last to avoid conflicts
  # Available at /auth/create-account, /auth/login, /auth/logout, etc.
  # All endpoints accept and return JSON
  mount RodauthApp, at: "/auth"

  # Defines the root path route ("/")
  # root "posts#index"
end
