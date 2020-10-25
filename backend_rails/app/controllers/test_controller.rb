# frozen_string_literal: true

class TestController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin_user!

  def index
    render_ok('edimo')
  end
end
