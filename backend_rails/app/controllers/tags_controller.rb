# frozen_string_literal: true

class TagsController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request

  def create
    tag = Tag.create!(create_params)
    render_created(tag)
  end

  def destroy
    tag = Tag.find_by!(search_params)

    authorize tag, :owner?

    tag.destroy!

    render_destroyed
  end

  def index
    render_ok(Tag.where(user: current_user))
  end

  def show
    tag = Tag.find_by!(search_params)

    authorize tag, :owner?

    render_ok(tag)
  end

  def update
    tag = Tag.find_by!(search_params)

    authorize tag, :owner?

    tag.update!(update_params)

    render_ok(tag)
  end

  private

  def create_params
    params.permit(:name)
          .merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:name)
  end
end
