class ShareableListMemory < ApplicationRecord
  belongs_to :memory
  belongs_to :shareable_list
end