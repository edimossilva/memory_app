# frozen_string_literal: true

include ActionDispatch::TestProcess
FactoryBot.define do
  factory :memory_list_memory do
    association :memory_list
    association :memory
  end
end
