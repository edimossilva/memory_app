class MemoryListMemory < ApplicationRecord
  belongs_to :memory
  belongs_to :memory_list

  def serialize
    self
  end
end
