class MemoryTag < ApplicationRecord
  belongs_to :memory
  belongs_to :tag
  has_many :user, through: :memory

  validates :memory_id, uniqueness: { scope: :tag_id }

  def serialize
    MemoryTagSerializer.new(self)
  end
end
