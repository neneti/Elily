# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'MyComment' }
    user
    micropost
  end
end
