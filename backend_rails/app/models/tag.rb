class Tag < ApplicationRecord
  belongs_to :user
  has_many :memories, dependent: :nullify

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }
  def serialize
    TagSerializer.new self
  end
end
