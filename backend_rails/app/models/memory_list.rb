class MemoryList < ApplicationRecord
  belongs_to :user
  has_many :memory_list_memories, dependent: :destroy

  validates :name, presence: true
end
