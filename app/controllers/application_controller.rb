# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Pagy::Method
  include Pundit::Authorization

  private

  def authenticate
    rodauth.require_account
  end

  def current_user
    @current_user ||= Account.find(rodauth.session_value) if rodauth.authenticated?
  end
end
