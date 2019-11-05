require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:micropost) { FactoryBot.create(:micropost, user: other_user) }
  let(:like) do
    FactoryBot.create(:like, user: user, micropost: micropost)
  end

  context 'リレーションが正しく行わているとき' do
    it 'ユーザーの名前と記事のタイトルが正しいこと' do
      expect(like).to be_valid
      expect(like.user.name).to eq user.name
      expect(like.micropost.title).to eq micropost.title
    end
  end
end
