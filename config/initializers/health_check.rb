# config/initializers/health_check.rb

HealthCheck.setup do |config|
  # Add the default checks
  config.standard_checks = %w[database migrations custom]
  
  # Add additional checks for Rails Cruella's services  
  config.full_checks = %w[database migrations custom redis]
  
  # Configure Redis to use the same URL as Sidekiq (without password)
  config.redis_url = ENV.fetch("REDIS_URL", "redis://redis:6379/0")
  config.redis_password = nil  # Explicitly set to nil to prevent auth attempts
  
  # Set AWS region for S3 health checks
  ENV['AWS_REGION'] ||= 'us-east-1'
  
  # URI for health checks - supports multiple endpoints
  config.uri = "health_check"
  
  # Allow health checks without authentication
  config.http_status_for_error_text = 503
  config.http_status_for_error_object = 503
  
  # Add custom error messages
  config.include_error_in_response_body = false
  
  # Set maximum age for checking (in seconds) - useful for caching
  config.max_age = 30
  
  # Add basic authentication if needed in production
  # config.basic_auth_username = ENV["HEALTH_CHECK_USERNAME"]
  # config.basic_auth_password = ENV["HEALTH_CHECK_PASSWORD"]
  
  # Custom S3/MinIO check that works with Rails 8
  config.add_custom_check("s3") do
    begin
      if Rails.env.production? || ENV["USE_S3_STORAGE"] == "true"
        require 'aws-sdk-s3'
        
        client = Aws::S3::Client.new(
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
          region: ENV.fetch('AWS_REGION', 'us-east-1'),
          endpoint: ENV['AWS_ENDPOINT_URL'],
          force_path_style: ENV.fetch('AWS_FORCE_PATH_STYLE', 'true') == 'true'
        )
        
        bucket_name = ENV.fetch('AWS_BUCKET_NAME', 'local-rails-cruella')
        
        # Test list objects (read permission)
        client.list_objects_v2(bucket: bucket_name, max_keys: 1)
        
        # Test put object (write permission)  
        test_key = "health_check_#{Time.current.to_i}"
        client.put_object(bucket: bucket_name, key: test_key, body: "health check test")
        
        # Test delete object (delete permission)
        client.delete_object(bucket: bucket_name, key: test_key)
        
        ""  # Return empty string for success
      else
        ""  # Local storage is OK in development
      end
    rescue => e
      "S3 check failed: #{e.message}"
    end
  end
  
end