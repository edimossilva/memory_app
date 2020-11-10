# frozen_string_literal: true

class TagsController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request

  self.resource_class = Tag

  private

  def create_params
    params.permit(:name)
          .merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:name)
  end
end
