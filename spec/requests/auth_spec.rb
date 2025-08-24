# spec/requests/auth_spec.rb
require "swagger_helper"

RSpec.describe "Authentication API", type: :request do
  let(:user_email) { "test@example.com" }
  let(:user_password) { "password123" }

  path "/auth/create-account" do
    post "Create Account" do
      tags "Authentication"
      description "Create a new user account"
      consumes "application/json"
      produces "application/json"

      parameter name: :account, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, description: "Email address for the account", example: "user@example.com" },
          password: { type: :string, description: "Password (minimum 8 characters)", example: "password123" }
        },
        required: ["email", "password"]
      }

      response "200", "Account created successfully" do
        schema type: :object,
               properties: {
                 success: { type: :string, example: "Your account has been created" }
               }

        let(:account) { { email: user_email, password: user_password } }

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end

      response "422", "Validation errors" do
        schema type: :object,
               properties: {
                 error: { type: :string, example: "There was an error creating your account" },
                 "field-error": { type: :string, example: "password is too short (minimum is 8 characters)" }
               }

        let(:account) { { email: "", password: "short" } }

        run_test!
      end
    end
  end

  path "/auth/login" do
    post "Login" do
      tags "Authentication"
      description "Login to get JWT tokens"
      consumes "application/json"
      produces "application/json"

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, description: "Email address for the account", example: "user@example.com" },
          password: { type: :string, description: "Password for the account", example: "password123" }
        },
        required: ["email", "password"]
      }

      response "200", "Login successful" do
        schema type: :object,
               properties: {
                 access_token: { type: :string, example: "eyJhbGciOiJIUzI1NiJ9...", description: "JWT access token" },
                 refresh_token: { type: :string, example: "eyJhbGciOiJIUzI1NiJ9...", description: "JWT refresh token" },
                 success: { type: :string, example: "You have been logged in" }
               }

        let(:credentials) { { email: user_email, password: user_password } }

        before do
          post "/auth/create-account", params: { email: user_email, password: user_password }
        end

        run_test!
      end

      response "401", "Invalid credentials" do
        schema type: :object,
               properties: {
                 error: { type: :string, example: "There was an error logging in" }
               }

        let(:credentials) { { email: "wrong@example.com", password: "wrongpass" } }

        run_test!
      end
    end
  end

  path "/auth/logout" do
    post "Logout" do
      tags "Authentication"
      description "Logout and invalidate JWT token"
      consumes "application/json"
      produces "application/json"
      security [{ bearerAuth: [] }]

      parameter name: :logout_body, in: :body, schema: {
        type: :object,
        properties: {}
      }, required: false

      response "200", "Logout successful" do
        schema type: :object,
               properties: {
                 success: { type: :string, example: "You have been logged out" }
               }

        let(:logout_body) { {} }

        run_test!
      end
    end
  end

  path "/auth/jwt-refresh" do
    post "Refresh JWT Token" do
      tags "Authentication"
      description "Refresh JWT access token using refresh token. Requires both Authorization header with access token (can be expired) and refresh token in request body."
      consumes "application/json"
      produces "application/json"
      security [{ bearerAuth: [] }]

      parameter name: :refresh_params, in: :body, schema: {
        type: :object,
        properties: {
          refresh_token: { type: :string, description: "JWT refresh token", example: "eyJhbGciOiJIUzI1NiJ9..." }
        },
        required: ["refresh_token"]
      }

      response "200", "Token refreshed successfully" do
        schema type: :object,
               properties: {
                 access_token: { type: :string, example: "eyJhbGciOiJIUzI1NiJ9...", description: "New JWT access token" },
                 refresh_token: { type: :string, example: "eyJhbGciOiJIUzI1NiJ9...", description: "New JWT refresh token" }
               }

        let(:refresh_params) { { refresh_token: "sample-refresh-token" } }

        run_test!
      end

      response "401", "Invalid or expired refresh token" do
        schema type: :object,
               properties: {
                 error: { type: :string, example: "no JWT access token provided during refresh" }
               }

        let(:refresh_params) { { refresh_token: "invalid-refresh-token" } }

        run_test!
      end
    end
  end

  path "/auth/close-account" do
    post "Close Account" do
      tags "Authentication"
      description "Close/delete user account"
      consumes "application/json"
      produces "application/json"
      security [{ bearerAuth: [] }]

      parameter name: :close_params, in: :body, schema: {
        type: :object,
        properties: {
          password: { type: :string, description: "Current account password", example: "currentpassword" }
        },
        required: ["password"]
      }

      response "200", "Account closed successfully" do
        schema type: :object,
               properties: {
                 success: { type: :string, example: "Your account has been closed" }
               }

        let(:close_params) { { password: user_password } }

        run_test!
      end

      response "401", "Invalid password or not authenticated" do
        schema type: :object,
               properties: {
                 error: { type: :string, example: "There was an error closing your account" }
               }

        let(:close_params) { { password: "wrongpassword" } }

        run_test!
      end
    end
  end
end
