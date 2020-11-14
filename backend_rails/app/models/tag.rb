class Tag < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }
  def serialize
    TagSerializer.new self
  end
end
