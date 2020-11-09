# frozen_string_literal: true

include ActionDispatch::TestProcess
FactoryBot.define do
  factory :tag do
    name { Faker::Name.unique.name.tr("\u0000", '') }
    association :user
  end
end
