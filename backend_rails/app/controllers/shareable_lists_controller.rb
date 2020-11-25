# frozen_string_literal: true

class ShareableListsController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request

  self.resource_class = ShareableList

  def create
    shareable_list = ShareableList.create!(create_params)

    memories_ids.each do |memory_id|
      shareable_list_memory = ShareableListMemory.new(memory_id: memory_id, shareable_list: shareable_list)
      authorize shareable_list_memory, :owner?
      shareable_list_memory.save
    end

    render_created(shareable_list.reload)
  end

  private

  def create_params
    params.permit(:name).merge(user_id: current_user.id)
  end

  def memories_ids
    params.permit(memories_ids: [])[:memories_ids]
  end
end
