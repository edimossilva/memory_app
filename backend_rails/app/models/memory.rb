# frozen_string_literal: true

class Memory < ApplicationRecord
  belongs_to :user
  belongs_to :tag, optional: true

  validates :key, :value, presence: true
  validates :key, uniqueness: { scope: :user_id, case_sensitive: false }
end
