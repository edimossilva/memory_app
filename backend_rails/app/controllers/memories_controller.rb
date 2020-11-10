# frozen_string_literal: true

class MemoriesController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request

  self.resource_class = Memory

  private

  def create_params
    params.permit(:key, :value, :visibility)
          .merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:key, :value, :visibility)
  end
end
