# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションの確認' do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:other_user) }
    let(:other_micropost) { FactoryBot.create(:other_micropost, user: other_user) }
    let(:comment) { FactoryBot.create(:comment, user: user, micropost: other_micropost) }

    describe '有効' do
      context 'コメントの文字数が範囲内のとき' do
        it 'コメントが有効となること' do
          expect(comment).to be_valid
        end
      end

      context 'リレーションが正しく行わているとき' do
        it 'ユーザー名とタイトルが正しいこと' do
          expect(comment.user.name).to eq user.name
          expect(comment.micropost.title).to eq other_micropost.title
        end
      end
    end

    describe '無効' do
      context 'コメント内容が存在しないとき' do
        it 'コメントが無効となること' do
          comment.content = nil
          expect(comment).not_to be_valid
        end
      end

      context 'コメントが文字数オーバーのとき' do
        it 'コメントが無効となること' do
          comment.content = 'a' * 51
          expect(comment).not_to be_valid
        end
      end
    end
  end
end
