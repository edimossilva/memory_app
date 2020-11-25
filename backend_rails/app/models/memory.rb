# frozen_string_literal: true

class Memory < ApplicationRecord
  belongs_to :user
  has_many :memory_tags, dependent: :destroy
  has_many :shareable_list_memories, dependent: :destroy
  has_many :tags, through: :memory_tags

  validates :key, :value, presence: true
  validates :key, uniqueness: { scope: :user_id, case_sensitive: false }

  def associate_memory_tags(new_memory_tags)
    new_memory_tags.each do |new_memory_tag|
      new_memory_tag.memory_id = id
    end

    new_memory_tags
  end

  def serialize
    MemorySerializer.new(self)
  end

  def memory_tags_not_included(tags_ids)
    not_included_tags_ids = tags.map(&:id) - tags_ids
    MemoryTag.where(tag_id: not_included_tags_ids)
  end

  def remove_old_memory_tags(new_memory_tags)
    new_memory_tags.select do |new_memory_tag|
      memory_tags.where(tag_id: new_memory_tag.tag_id).empty?
    end
  end
end
