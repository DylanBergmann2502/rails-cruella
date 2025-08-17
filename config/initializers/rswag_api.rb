Rswag::Api.configure do |c|

  # Specify a root folder where Swagger JSON files are located
  # This is used by the Swagger middleware to serve requests for API descriptions
  # NOTE: If you're using rswag-specs to generate Swagger, you'll need to ensure
  # that it's configured to generate files in the same folder
  c.openapi_root = Rails.root.to_s + '/swagger'

  # Inject a lambda function to alter the returned Swagger prior to serialization
  # The function will have access to the rack env for the current request
  # Dynamically assign the server URL based on the current request
  c.swagger_filter = lambda { |swagger, env| 
    protocol = env['rack.url_scheme'] || 'http'
    host = env['HTTP_HOST'] || 'localhost'
    swagger['servers'] = [{ 
      'url' => "#{protocol}://#{host}",
      'description' => 'Current server'
    }]
  }
end
