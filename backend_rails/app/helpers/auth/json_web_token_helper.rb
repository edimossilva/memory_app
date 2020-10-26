# frozen_string_literal: true

module Auth
  module JsonWebTokenHelper
    SECRET_KEY = Rails.application.credentials.jwt[:secret_key]

    def user_to_auth_json(user)
      token = encode_user(user)
      time = Time.zone.now + 24.hours.to_i
      {
        token: token,
        exp: time.strftime('%m-%d-%Y %H:%M'),
        username: user.username,
        userId: user.id,
        accessLevel: user.access_level
      }
    end

    def encode_user(user, exp = 24.hours.from_now)
      payload = {}
      payload[:exp] = exp.to_i
      payload[:user_id] = user.id

      JWT.encode(payload, SECRET_KEY)
    end

    def decode_token(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end

    def header_for_user(user)
      { 'Authorization' => encode_user(user) }
    end

    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        # rubocop:disable Rails/HelperInstanceVariable
        @current_user = user_by_token(header)
      rescue JWT::DecodeError
        render_unauthorized
      end
    end

    def user_by_token(token)
      decoded = decode_token(token)
      User.find(decoded[:user_id])
    end

    def current_user
      @current_user
      # rubocop:enable Rails/HelperInstanceVariable
    end
  end
end
