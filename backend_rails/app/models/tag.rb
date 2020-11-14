class Tag < ApplicationRecord
  belongs_to :user
  has_many :memory_tags, dependent: false
  has_many :memories, through: :memory_tags

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }

  def serialize
    TagSerializer.new self
  end
end
