FactoryBot.define do
  factory :user do
    name { 'ユーザーA' }
    email { 'test000@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :other_user, class: 'User' do
    sequence(:name) { |n| "アザーユーザー_#{n}" }
    sequence(:email) { |n| "other_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    profile { '自己紹介文' }
  end
end
