class Tag < ApplicationRecord
  belongs_to :user
  has_many :memories_tags, dependent: false
  has_many :memories, through: :memories_tags

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }

  def serialize
    TagSerializer.new self
  end
end
