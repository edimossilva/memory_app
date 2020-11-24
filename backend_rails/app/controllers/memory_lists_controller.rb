# frozen_string_literal: true

class MemoryListsController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request

  self.resource_class = MemoryList

  def create
    memory_list = MemoryList.create!(create_params)

    memories_ids.each do |memory_id|
      memory_list_memory = MemoryListMemory.new(memory_id: memory_id, memory_list: memory_list)
      authorize memory_list_memory, :owner?
      memory_list_memory.save
    end

    render_created(memory_list.reload)
  end

  private

  def create_params
    params.permit(:name).merge(user_id: current_user.id)
  end

  def memories_ids
    params.permit(memories_ids: [])[:memories_ids]
  end
end
