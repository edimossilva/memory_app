class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request, except: :omniauth

  def omniauth
    user = User.from_omniauth(auth)
    user.save
    render json: user_to_auth_json(user)
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
