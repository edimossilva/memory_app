class TestsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request, except: %i[delete_test_user_data]

  def delete_test_user_data
    user = User.find_by(username: 'test_user')
    user.memories.destroy_all
    user.tags.destroy_all
    render_ok(user)
  end
end
