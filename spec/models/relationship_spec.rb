# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:relationship) do
    FactoryBot.create(:relationship, follower: user, followed: other_user)
  end

  context 'リレーションが正しく行わているとき' do
    it 'フォローとフォロワーと名前が正しいこと' do
      expect(relationship).to be_valid
      expect(relationship.follower.name).to eq user.name
      expect(relationship.followed.name).to eq other_user.name
    end
  end
end
