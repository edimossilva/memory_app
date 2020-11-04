class SessionsController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request, except: :omniauth

  def omniauth
    user = User.from_omniauth(auth)
    user.save
    omniauth_callback_url = ENV['OMNIAUTH_CALLBACK_URL']
    redirect_to generate_url(omniauth_callback_url, user_to_auth_json(user))
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def generate_url(url, params = {})
    uri = URI(url)
    uri.query = params.to_query
    uri.to_s
  end
end
