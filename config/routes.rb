# config/routes.rb
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api/docs'
  mount Rswag::Api::Engine => '/api/docs'
  
  # ReDoc endpoint for alternative API documentation
  get '/api/redoc', to: 'redoc#index'
  
  # Rodauth authentication endpoints
  # Available at /auth/create-account, /auth/login, /auth/logout, etc.
  # All endpoints accept and return JSON
  mount RodauthApp, at: "/"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Comprehensive health checks using health_check gem
  # Available endpoints:
  # /health_check - Basic checks (database, migrations, custom)
  # /health_check/all - Full checks (database, migrations, custom, redis, sidekiq-redis, s3)
  # /health_check/database - Database connectivity only
  # /health_check/redis - Redis connectivity only
  # /health_check/s3 - S3/MinIO connectivity only
  health_check_routes

  # Keep the simple /up endpoint for basic load balancer checks
  # Returns 200 if the app boots with no exceptions, otherwise 500
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
