FactoryBot.define do
  factory :micropost do
    title { 'M_title' }
    content { 'M_content' }
    user
  end

  factory :other_micropost, class: 'Micropost' do
    sequence(:title) { |n| "M_other_title_#{n}" }
    content  { 'M_other_author' }
    user
  end
end
