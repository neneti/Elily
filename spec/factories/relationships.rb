# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    trait :with_dependents do
      follower
      followed
    end
  end
end
