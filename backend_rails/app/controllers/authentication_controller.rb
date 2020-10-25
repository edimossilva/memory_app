# frozen_string_literal: true

class AuthenticationController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request, except: %i[login sign_up]

  def login
    user = User.find_by(username: login_params[:username])

    if user&.authenticate(login_params[:password])
      json = user_to_auth_json(user)
      render json: json, status: :ok
    else
      render_unauthorized
    end
  end

  def sign_up
    redirect_to '/auth/google_oauth2'
  end

  def check
    render json: user_to_auth_json(@current_user)
  end

  private

  def login_params
    params.permit(:username, :password)
  end
end
