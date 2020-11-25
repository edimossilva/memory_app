# frozen_string_literal: true

include ActionDispatch::TestProcess
FactoryBot.define do
  factory :shareable_list_memory do
    association :shareable_list
    association :memory
  end
end
