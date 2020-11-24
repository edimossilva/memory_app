class MemoryList < ApplicationRecord
  belongs_to :user
  has_many :memory_list_memories, dependent: :destroy
  has_many :memories, through: :memory_list_memories

  validates :name, presence: true
end
