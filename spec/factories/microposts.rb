include ActionDispatch::TestProcess
FactoryBot.define do
  factory :micropost do
    id {1}
    user_id {1}
    title { 'M_title' }
    content { 'M_content' }
    tag_list {'tag2'}
    start_time {'2019-11-01 00:00:00'}
    created_at {'2019-11-01 00:00:00'}
    after(:build) do |micropost|
      micropost.illusts = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'test.jpg'), 'image/jpg')
    end
    user
  end

  factory :other_micropost, class: 'Micropost' do
    id {2}
    user_id {2}
    title {'M_other_title'}
    content  { 'M_other_author' }
    tag_list {'tag1'}
    start_time {'2019-11-01 00:00:00'}
    created_at {'2019-11-01 00:00:00'}
    after(:build) do |micropost|
      micropost.illusts = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'test.jpg'), 'image/jpg')
    end
    user
  end
end
