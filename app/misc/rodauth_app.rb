# app/misc/rodauth_app.rb
class RodauthApp < Rodauth::Rails::App
    # primary configuration with custom prefix override
    configure RodauthMain do
      # Override the prefix to avoid double /auth when mounted at /auth
      prefix nil
    end

    # secondary configuration
    # configure RodauthAdmin, :admin

    route do |r|
    r.rodauth # route rodauth requests

    # ==> Authenticating requests
    # Call `rodauth.require_account` for requests that you want to
    # require authentication for. For example:
    #
    # # authenticate /dashboard/* and /account/* requests
    # if r.path.start_with?("/dashboard") || r.path.start_with?("/account")
    #   rodauth.require_account
    # end

    # ==> Secondary configurations
    # r.rodauth(:admin) # route admin rodauth requests
  end
end
