include ActionDispatch::TestProcess
FactoryBot.define do
  factory :user do
    id {1}
    name { 'ユーザーA' }
    email { 'test000@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    activated {1}
    after(:build) do |user|
      user.avatar = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'avatar1.jpg'), 'image/jpg')
    end
  end

  factory :other_user, class: 'User' do
    id {2}
    name { "アザーユーザー_" }
    email { "other_@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    profile { '自己紹介文' }
    activated {1}
    after(:build) do |user|
      user.avatar = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'avatar2.jpg'), 'image/jpg')
    end
  end
end
