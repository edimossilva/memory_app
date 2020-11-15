# frozen_string_literal: true

class MemoriesController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request

  self.resource_class = Memory

  def update
    memory = Memory.find_by!(search_params)
    authorize memory, :owner?

    memory_tags = tags_ids.map do |tag_id|
      memory_tag = MemoryTag.new(tag_id: tag_id, memory_id: memory.id)
      authorize memory_tag, :owner?
      return render_unauthorized(tag_id) unless memory_tag.valid?

      memory_tag
    end

    memory.update!(update_params)

    memory.memory_tags_not_included(tags_ids).each(&:destroy!)
    memory_tags.each(&:save!)

    render_ok(memory.reload)
  end

  private

  def create_params
    params.permit(:key, :value, :visibility, :tags_ids)
          .merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:key, :value, :visibility, :tags_ids)
  end

  def tags_ids
    params.fetch(:tags_ids, [])
  end
end
