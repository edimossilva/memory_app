class ShareableList < ApplicationRecord
  belongs_to :user
  has_many :shareable_list_memories, dependent: :destroy
  has_many :memories, through: :shareable_list_memories

  validates :name, presence: true

  def serialize
    self
  end
end
