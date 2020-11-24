# frozen_string_literal: true

include ActionDispatch::TestProcess
FactoryBot.define do
  factory :memory_list do
    association :user
    name { Faker::Book.unique.title }
  end
end
