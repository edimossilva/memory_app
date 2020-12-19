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

  def update
    shareable_list = ShareableList.find_by(find_params)
    shareable_list.update!(update_params)

    current_memories_id = shareable_list.memories.pluck(:id)

    memories_to_add = memories_ids - current_memories_id
    memories_to_add.each do |memory_id|
      shareable_list_memory = ShareableListMemory.new(memory_id: memory_id, shareable_list: shareable_list)
      authorize shareable_list_memory, :owner?
      shareable_list_memory.save
    end

    memories_to_remove = current_memories_id - memories_ids
    memories_to_remove.each do |memory_id|
      shareable_list_memory = ShareableListMemory.find_by!(memory_id: memory_id, shareable_list: shareable_list)
      shareable_list_memory.destroy!
    end
    render_ok(shareable_list)
  end

  private

  def find_params
    params.permit(:id)
  end

  def create_params
    params.permit(:name).merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:name)
  end

  def memories_ids
    params.permit(memories_ids: [])[:memories_ids] || []
  end
end
