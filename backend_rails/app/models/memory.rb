# frozen_string_literal: true

class Memory < ApplicationRecord
  belongs_to :user
  has_many :memory_tags, dependent: false
  has_many :tags, through: :memory_tags

  validates :key, :value, presence: true
  validates :key, uniqueness: { scope: :user_id, case_sensitive: false }

  def serialize
    MemorySerializer.new(self)
  end

  def memory_tags_not_included(tags_ids)
    not_included_tags_ids = tags.map(&:id) - tags_ids
    MemoryTag.where(tag_id: not_included_tags_ids)
  end
end
