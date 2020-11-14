# frozen_string_literal: true

class MemoryTagsController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request

  self.resource_class = MemoryTag

  def create
    create_params.each do |param|
      memory_tag = MemoryTag.new(param)
      authorize memory_tag, :owner?
    end

    resource = resource_class.create!(create_params)

    render_created(resource)
  end

  private

  def create_params
    memory_tags = params.require(:memory_tags)

    memory_tags.map do |memory_tag|
      memory_tag.permit(:memory_id, :tag_id)
    end
  end

  def update_params
    params.permit(:memory_tags)
  end
end
