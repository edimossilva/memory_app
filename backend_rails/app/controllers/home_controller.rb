# frozen_string_literal: true

class HomeController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request, except: %i[hello]
  def hello
    render_ok('hello :)')
  end
end
