# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    trait :with_dependents do
      user
      micropost
    end
  end
end
