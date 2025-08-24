# app/controllers/redoc_controller.rb
class RedocController < ApplicationController
  def index
    # Serve ReDoc HTML that consumes the same OpenAPI spec as Swagger UI
    render html: redoc_html.html_safe
  end

  private

  def redoc_html
    <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <title>#{Rails.application.class.module_parent_name} API - ReDoc</title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,700|Roboto:300,400,700" rel="stylesheet">
        <style>
          body { margin: 0; padding: 0; }
        </style>
      </head>
      <body>
        <redoc spec-url="#{request.base_url}/api/docs/v1/swagger.yaml"></redoc>
        <script src="https://cdn.redoc.ly/redoc/latest/bundles/redoc.standalone.js"></script>
      </body>
      </html>
    HTML
  end
end
