class MemoryTag < ApplicationRecord
  belongs_to :memory
  belongs_to :tag
  has_many :user, through: :memory

  def serialize
    MemoryTagSerializer.new(self)
  end
end
