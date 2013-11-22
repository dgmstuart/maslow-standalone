class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionController::InvalidAuthenticityToken do
    render "public/422", layout: false, status: 422
  end

  include GDS::SSO::ControllerMethods

  before_filter :authenticate_user!
  before_filter :require_signin_permission!

  private
    def verify_authenticity_token
      raise ActionController::InvalidAuthenticityToken unless verified_request?
    end
end
