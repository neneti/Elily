# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost, user: user) }

  describe '有効' do
    context '全ての項目に正しい値が存在するとき' do
      it '投稿が有効となること' do
        expect(micropost).to be_valid
      end
    end

    context 'リレーションが正しく行わているとき' do
      it 'ユーザー名が一致すること' do
        expect(micropost.user.name).to eq user.name
      end
    end
  end

  describe '無効' do
    context 'タイトルが存在しないとき' do
      it '投稿が無効となること' do
        micropost.title = nil
        expect(micropost).not_to be_valid
      end
    end

    context 'イラストのサイズが1MBより大きいとき' do
      it '投稿が無効となること' do
        micropost.illusts.blob.byte_size = 2.megabytes
        expect(micropost).not_to be_valid
      end
    end
  end
end
